# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {resource: resource, token: request.env['warden-jwt_auth.token']}
  end

  def respond_to_on_destroy
    head :no_content
  end
end
