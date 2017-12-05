class TasksController < ApplicationController
  before_action :forbid_not_login_user

  def index
    if params[:label].present?
      @yet_tasks = @current_user.tasks.yet.get_by_label(params[:label])
      @doing_tasks = @current_user.tasks.doing.get_by_label(params[:label])
      @done_tasks = @current_user.tasks.done.get_by_label(params[:label])
    else
      @yet_tasks = @current_user.tasks.yet
      @doing_tasks = @current_user.tasks.doing
      @done_tasks = @current_user.tasks.done
    end
    @task = Task.new
    @label = params[:label]
  end

  def create
    /renderのときのためのindexの変数達/
    if params[:label].present?
      @yet_tasks = @current_user.tasks.yet.get_by_label(params[:label])
      @doing_tasks = @current_user.tasks.doing.get_by_label(params[:label])
      @done_tasks = @current_user.tasks.done.get_by_label(params[:label])
    else
      @yet_tasks = @current_user.tasks.yet
      @doing_tasks = @current_user.tasks.doing
      @done_tasks = @current_user.tasks.done
    end

    @task = Task.new(task_params)
    @task.status = "yet"
    @task.user_id = @current_user.id
    if @task.save
      redirect_to tasks_path, notice: "新しいタスクを作成しました" 
    else 
      render :index
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました"
    else 
      render :edit
    end    
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, "タスクを削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :status, :due_date, :label)
  end
end
