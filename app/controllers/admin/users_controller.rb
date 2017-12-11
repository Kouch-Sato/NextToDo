class Admin::UsersController < ApplicationController
  layout "admin_layout"

  before_action :forbid_not_login_user
  before_action :forbid_not_admin_user

  def index
    @users = User.all
    @user = User.new
  end

  def create
    @users = User.all
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "アカウントを作成しました"
    else
      render :index
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "アカウントを編集しました"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :image, :role)
  end

  def forbid_not_admin_user
    if @current_user.role != "admin"
      redirect_to user_tasks_path, alert:"あなたは管理ユーザーではありません"
    end
  end

end
