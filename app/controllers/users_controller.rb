class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path, notice: "アカウントを作成しました"
    else
      render :new
    end
  end

  def destroy
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end

end
