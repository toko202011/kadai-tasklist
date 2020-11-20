class TasksController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc)
    end
  end

  def show
    set_task
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to root_url
    else
      @task = current_user.tasks.order(id: :desc)
      flash[:danger] = 'タスクが登録されませんでした'
      render '/'
    end
  end

  def edit
    set_task
  end

  def update
    set_task
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  # strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end
end