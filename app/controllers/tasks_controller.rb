class TasksController < ApplicationController

  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(id: :desc)
  end

  def show
    correct_user
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
      flash[:danger] = 'タスクが登録されませんでした'
      render :new
    end
  end

  def edit
    correct_user
  end

  def update
    correct_user
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    correct_user
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

end