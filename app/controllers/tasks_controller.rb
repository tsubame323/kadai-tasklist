class TasksController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :show, :update, :edit]
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
    @task = current_user.tasks.build
  end
  
def new
  @task = Task.new
end

def show
  @task = Task.find(params[:id])
end

  def create
      @task = current_user.tasks.build(task_params)
      
      if @task.save
          flash[:success] = "Task　投稿完了"
          redirect_to root_url
      else
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])
          flash.now[:danger] = "Task 投稿失敗"
          render :new
      end
  end

  def edit
      @task = Task.find(params[:id])
  end

  def update
      @task = Task.find(params[:id])
      
      if @task.update(task_params)
          flash[:success] = "Task 更新完了"
          redirect_to root_url
      else
          flash.now[:danger] = "Task 更新失敗"
          render :edit
      end
  end

  def destroy
    @task.destroy

  flash[:success] = 'Task削除'
  redirect_to root_url
  end
  

  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user)
  end
  
  def correct_user
    @task = Task.find(params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
