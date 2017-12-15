class User::TasksController < ApplicationController
  before_action :forbid_not_login_user
  PER = 5

  def index
    if params[:label].present?
      @yet_tasks = @current_user.tasks.yet.get_by_label(params[:label]).page(params[:yet_tasks_page]).per(PER)
      @doing_tasks = @current_user.tasks.doing.get_by_label(params[:label]).page(params[:doing_tasks_page]).per(PER)
      @done_tasks = @current_user.tasks.done.get_by_label(params[:label]).page(params[:done_tasks_page]).per(PER)
      @share_tasks = Task.share.get_by_label(params[:label]).page(params[:share_tasks_page]).per(PER)
      @alert_tasks = @current_user.tasks.alert.get_by_label(params[:label]).page(params[:alert_tasks_page]).per(PER)
    else
      @yet_tasks = @current_user.tasks.yet.page(params[:yet_tasks_page]).per(PER)
      @doing_tasks = @current_user.tasks.doing.page(params[:doing_tasks_page]).per(PER)
      @done_tasks = @current_user.tasks.done.page(params[:done_tasks_page]).per(PER)
      @share_tasks = Task.share.page(params[:share_tasks_page]).per(PER)
      @alert_tasks = @current_user.tasks.alert.page(params[:alert_tasks_page]).per(PER)
    end
    @task = Task.new
  end

  def create
    /renderのときのためのindexの変数達/
    if params[:label].present?
      @yet_tasks = @current_user.tasks.yet.get_by_label(params[:label]).page(params[:yet_tasks_page]).per(PER)
      @doing_tasks = @current_user.tasks.doing.get_by_label(params[:label]).page(params[:doing_tasks_page]).per(PER)
      @done_tasks = @current_user.tasks.done.get_by_label(params[:label]).page(params[:done_tasks_page]).per(PER)
      @share_tasks = Task.share.get_by_label(params[:label]).page(params[:share_tasks_page]).per(PER)
      @alert_tasks = @current_user.tasks.alert.get_by_label(params[:label]).page(params[:alert_tasks_page]).per(PER)
    else
      @yet_tasks = @current_user.tasks.yet.page(params[:yet_tasks_page]).per(PER)
      @doing_tasks = @current_user.tasks.doing.page(params[:doing_tasks_page]).per(PER)
      @done_tasks = @current_user.tasks.done.page(params[:done_tasks_page]).per(PER)
      @share_tasks = Task.share.page(params[:share_tasks_page]).per(PER)
      @alert_tasks = @current_user.tasks.alert.page(params[:alert_tasks_page]).per(PER)
    end

    @task = Task.new(task_params)
    @task.status = "yet"
    @task.user_id = @current_user.id
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
      @task.start = @task.due_date
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
    @tasks = Task.where("start IS NOT NULL")
    
    respond_to do |format|
      format.json {
        render json:
          @tasks.to_json(
            only: [:title, :start]
          )
      }
    end
  end

  def graph
    @tasks_data = @current_user.tasks.order('created_at ASC').group(:created_at).count
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :status, :due_date, :label, :share)
  end
end
