class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :navers_check, only: %i[create update]

  def index
    projects = Project.by_user(current_user.id)
    render json: format(projects)
  end

  def show
    project = Project.find(params[:id])
    render json: project.as_json(
      include: { navers: { except: [:user_id, :created_at, :updated_at] } }
    )
  end

  def create
    project = Project.create(name: params[:name], user_id: current_user.id)
    return render_json_validation_error(project) if project.errors.present?

    linked_naver(project.id) if params[:navers].present?
    render json: format(project), status: :created
  end

  def update
    project = Project.find(params[:id])
    return render_json_error('Não permitido', :unauthorized) unless valid_user?(project)

    project.update(name: params[:name])
    return render_json_validation_error(project) if project.errors.present?

    linked_naver(project.id) if params[:navers].present?
    render json: format(project)
  end

  def destroy
    project = Project.find(params[:id])
    return render_json_error('Não permitido', :unauthorized) unless valid_user?(project)

    return render_json_validation_error(project) unless project.destroy
    destroy_linked(project.id)
    render json: { message: 'Deletado com sucesso' }
  end

  private

  def valid_navers?
    Naver.by_ids(params[:navers]).count == params[:navers].count
  end

  def navers_check
    if params[:navers].present?
      return render_json_error('Um ou mais navers não existem', :bad_request) unless valid_navers?
    end
  end

  def linked_naver(project_id)
    destroy_linked(project_id)
    params[:navers].each do |naver|
      NaverProject.create(naver_id: naver, project_id: project_id)
    end
  end

  def destroy_linked(project_id)
    NaverProject.where(project_id: project_id).delete_all
  end
end