class ApplicationController < ActionController::API

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email]) do |u|
      u.permit(:name, :username, :email, :password,
               :password_confirmation, :avatar, :bio)
    end
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :username, :email, :password,
               :current_password, :avatar, :bio)
    end
  end
end
