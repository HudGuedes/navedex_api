class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |_e|
    render_json_error('Resource not found', :not_found)
  end

  def render_json_error(message, status)
    render json: { message: message }, status: status
  end

  def render_json_validation_error(resource)
    render json: { errors: resource.errors }, status: :bad_request
  end

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      render_json_validation_error(resource)
    end
  end

  def format(resource)
    resource.as_json(except: [:user_id])
  end

  def valid_user?(resouce)
    resouce.user_id == current_user.id
  end
end
