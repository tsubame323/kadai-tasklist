class TasksController < ApplicationController
  def index
      @tasks = Task.all.page(params[:page])
  end

  def show
      @task = Task.find(params[:id])
  end

  def new
      @task = Task.new
  end

  def create
      @task = Task.new(task_params)
      
      if @task.save
          flash[:success] = "Task　投稿完了"
          redirect_to @task
      else
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
          redirect_to @task
      else
          flash.now[:danger] = "Task 更新失敗"
          render :edit
      end
  end

  def destroy
      @task = Task.find(params[:id])
      @task.destroy
      
      flash[:success] = "Task 完了"
      redirect_to tasks_url
  end
  

  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
