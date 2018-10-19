class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?
 
  protected
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :remember_me, :image, :image_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password, :image, :image_cache, :remove_image])
  end
end
