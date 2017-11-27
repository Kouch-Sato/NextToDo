class TasksController < ApplicationController
  def index
    @yet_tasks = Task.all.where(status: "yet")
    @doing_tasks = Task.all.where(status: "doing")
    @done_tasks = Task.all.where(status: "done")
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.status = "yet"
    if @task.save
      redirect_to tasks_path
    else 
      redirect_to tasks_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update(task_params)
    redirect_to tasks_path
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to tasks_path
  end


  private 
  def task_params
    params.require(:task).permit(:title, :body, :status, :due_date, :label)
  end
end
