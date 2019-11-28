class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :destroy]
  
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが正しく記録されました"
      redirect_to @task
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = "タスクを記録できませんでした"
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end
  
  def update
    @task = current_user.tasks.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "タスクは正常に更新されました"
      redirect_to @task
    else
      flash .now[:denger] = "タスクを更新できませんでした"
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "タスクを削除しました"
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
    redirect_to root_url
    end
  end

end
