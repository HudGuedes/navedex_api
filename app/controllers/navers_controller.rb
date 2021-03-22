class NaversController < ApplicationController
  before_action :authenticate_user!
  before_action :projects_check, only: %i[create update]

  def index
    navers = Naver.by_user(current_user.id)
    render json: format(navers)
  end

  def show
    naver = Naver.find(params[:id])
    render json: naver.as_json(
      except: [:user_id],
      include: { projects: { only: [:id, :name] } }
    )
  end

  def create
    naver = Naver.create(naver_params.merge({ user_id: current_user.id }))
    return render_json_validation_error(naver) if naver.errors.present?

    linked_project(naver.id) if params[:projects].present?
    render json: format(naver), status: :created
  end

  def update
    naver = Naver.find(params[:id])
    return render_json_error('Não permitido', :unauthorized) unless valid_user?(naver)

    naver.update(naver_params)
    return render_json_validation_error(naver) if naver.errors.present?

    linked_project(naver.id) if params[:projects].present?
    render json: format(naver)
  end

  def destroy
    naver = Naver.find(params[:id])
    return render_json_error('Não permitido', :unauthorized) unless valid_user?(naver)

    return render_json_validation_error(naver) unless naver.destroy

    destroy_linked(naver.id)
    render json: { message: 'Deletado com sucesso' } 
  end

  private

  def naver_params
    {
      name: params[:name],
      birthdate: Date.parse(params[:birthdate]),
      admission_date: Date.parse(params[:admission_date]),
      job_role: params[:job_role]
    }
  end

  def valid_projects?
    Project.by_user(current_user.id).by_projects_id(params[:projects]).count == params[:projects].count
  end

  def projects_check
    if params[:projects].present?
      render_json_error('Um ou mais projetos não existem', :bad_request) unless valid_projects?
    end
  end

  def linked_project(naver_id)
    destroy_linked(naver_id)
    params[:projects].each do |project|
      NaverProject.find_or_create_by(naver_id: naver_id, project_id: project)
    end
  end

  def destroy_linked(naver_id)
    NaverProject.where(naver_id: naver_id).delete_all
  end
end