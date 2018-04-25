class User::TasksController < ApplicationController
  before_action :forbid_not_login_user
  PER = 5

  def index
    tasks_for_index(params)
    @task = Task.new
  end

  def create
    tasks_for_index(params)
    @task = Task.new(task_params)
    @task.user_id = @current_user.id
    @task.yet!
    if @task.save
      redirect_to user_tasks_path, notice: "新しいタスクを作成しました" 
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
      @task.save
      redirect_to user_tasks_path, notice: "タスクを編集しました"
    else 
      render :edit
    end    
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path, notice: "タスクを削除しました"
  end

  def calendar
  end

  def tasks
    tasks_for_calendar = Task.where.not(due_date: nil).map do |task|
        { start: task.due_date, title: task.title }
    end    

    respond_to do |format|
      format.json { render json: tasks_for_calendar }
    end
  end

  def graph
    @tasks_data = @current_user.tasks.order('created_at ASC').group(:created_at).count
    @tasks = Task.rank(:row_order)
  end

  def sort
    @task = Task.find_by(id: params[:task_id])
    @task.update(task_params)
    head :ok
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :status, :due_date, :label, :group_id, :row_order_position, :file)
  end

  def tasks_for_index(params)
    @tasks = @current_user.user_group_tasks.or(@current_user.tasks)
    if params[:label].present?
      @yet_tasks = @tasks.yet.get_by_label(params[:label]).page(params[:yet_tasks_page]).per(PER).desc
      @doing_tasks = @tasks.doing.get_by_label(params[:label]).page(params[:doing_tasks_page]).per(PER).desc
      @done_tasks = @tasks.done.get_by_label(params[:label]).page(params[:done_tasks_page]).per(PER).desc
      @alert_tasks = @tasks.alert.get_by_label(params[:label]).page(params[:alert_tasks_page]).per(PER).desc
    else
      #@yet_tasks = @current_user.tasks.yet.page(params[:yet_tasks_page]).per(PER).desc
      @yet_tasks = @tasks.yet.page(params[:yet_tasks_page]).per(PER).desc
      @doing_tasks = @tasks.doing.page(params[:doing_tasks_page]).per(PER).desc
      @done_tasks = @tasks.done.page(params[:done_tasks_page]).per(PER).desc
      @alert_tasks = @tasks.alert.page(params[:alert_tasks_page]).per(PER).desc
    end
  end  
  
end
