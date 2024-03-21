class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: :index
  before_action :configure_sign_up_params, if: :devise_controller?

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password])
  end

  def after_sign_up_path_for(resource)
    plaid_new_path
  end

  def after_inactive_sign_up_path_for(resource)
    plaid_new_path
  end
end
