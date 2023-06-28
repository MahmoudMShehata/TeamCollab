class TaskPoolsController < ApplicationController
  # before_action :require_team_leader, only: [:create, :update, :destroy]
  before_action :find_task_pool, only: [:show, :update, :destroy, :add_task]
  authorize_resource

  def index
    @teamleader = User.find(current_user.id)
    @tasks_pools = @teamleader.task_pools
  end

  def show
    @tasks_pool = TaskPool.find(params[:id])
    @tasks = @tasks_pool.tasks
  end

  def create
    # debugger
    @task_pool = TaskPool.create!(name: params[:name], team_leader_id: current_user.id)

    redirect_to task_pools_path

    # if @task_pool.save
    #   redirect_to task_pool_path(@task_pool)
    # else
    #   render :new
    # end
  end

  # def update
  #   if @task_pool.update(task_pool_params)
  #     redirect_to task_pool_path(@task_pool)
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @task_pool.destroy
    redirect_to task_pools_path
  end

  def add_task
    @task = @task_pool.tasks.create!(task_params)
    if @task.save
      redirect_to task_pool_path(@task_pool)
    else
      redirect_to task_pool_path(@task_pool)
    end
  end

  private

  def find_task_pool
    @task_pool = TaskPool.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :type, :description, :deadline, :assignee_id).merge(progress: "to_do")
  end

  # def require_team_leader
  #   redirect_to(root_path) unless current_user and current_user.teamleader?
  # end
end
