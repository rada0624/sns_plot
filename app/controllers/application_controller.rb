class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_user_info

  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_update_path_for(resource)
    mypage_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :job, :birth, :is_open])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :job, :birth, :is_open])
  end

  protected
  def get_user_info
    if user_signed_in?
      @users = User.find_by(id: current_user.id)
    end
  end

end
