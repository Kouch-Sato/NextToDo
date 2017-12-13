class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user 

  private
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def forbid_not_login_user
    if @current_user.blank?
      redirect_to login_path, alert: "ログインしてください"
    end
  end

  def forbid_login_user
    if @current_user.present?
      redirect_to user_tasks_path, alert:"既にログインしています"
    end
  end
end
