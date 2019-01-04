class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  before_action :correct_user, only: [:destroy, :edit]
  
  def index
    if logged_in?
      @tasks = Task.all.page(params[:page])
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = '新しいタスクが作られました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'ERRORが起きました。やり直して下さい'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'タスクが更新されました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'ERRORが起きました。やり直して下さい'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクが削除されました'
    redirect_to @task
  end
  
  private
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