class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "ログインしました！"
    else
      render "/home/top"
    end
  end

  def new
  end

  def destroy
    reset_session
    redirect_to tasks_path, notice: "ログアウトしました"
  end
  
end
