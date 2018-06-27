class UsersController < ApplicationController
  before_action :forbid_not_login_user, only: [:edit, :update, :logout]
  before_action :forbid_login_user, only: [:login, :login_form]
  before_action :ensure_corrent_user, only: [:edit, :update]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_tasks_path
    else
      render :edit
    end
  end

  #session周り

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to user_tasks_path, notice: "ログインしました！"
    else
      redirect_to login_path, alert: "メールアドレスかパスワードが違います"
    end
  end

  def login_form
  end

  def logout
    reset_session
    redirect_to login_path, notice: "ログアウトしました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end

  def ensure_corrent_user
    if session[:user_id] != params[:id].to_i
      redirect_to user_tasks_path, notice: "他のユーザーの情報は編集できません"
    end
  end
  
end
