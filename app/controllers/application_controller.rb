class ApplicationController < ActionController::Base

  require "csv"

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_user_info

  def after_sign_in_path_for(resource)
    users_field_path
    if Field.find_by(user_id: current_user.id).blank?
      @user_id_seq = 1

      CSV.foreach('db/insert_fields_data.csv') do |info|
        if info[2].to_i.eql?1
        Field.create(:user_id => current_user.id, :user_id_seq => @user_id_seq , :color_code => info[1], :is_available => '1', :category1 => info[3], :category2 => info[4])
        @user_id_seq = @user_id_seq + 1
        end
      end
      users_field_path
    else
      mypage_path
    end

  end

  def after_update_path_for(resource)
    mypage_path
  end

  def after_sign_up_path_for(resource)
    users_field_path
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
