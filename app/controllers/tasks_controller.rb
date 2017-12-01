class TasksController < ApplicationController
  before_action :forbid_not_login_user

  def index
    @yet_tasks = @current_user.tasks.all.yet
    @doing_tasks = @current_user.tasks.all.doing
    @done_tasks = @current_user.tasks.all.done
    if params[:label].present?
      @yet_tasks = @current_user.tasks.all.yet.get_by_label(params[:label])
      @doing_tasks = @current_user.tasks.all.doing.get_by_label(params[:label])
      @done_tasks = @current_user.tasks.all.done.get_by_label(params[:label])
    end
    @task = Task.new
    @label = params[:label]
  end

  def create
    @task = Task.new(task_params)
    @task.status = "yet"
    @task.user_id = @current_user.id
    if @task.save
      redirect_to tasks_path
    else 
      redirect_to tasks_path
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to tasks_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :status, :due_date, :label)
  end
end
