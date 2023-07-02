# frozen_string_literal: true

class TaskPoolsController < ApplicationController
  before_action :find_task_pool, only: %i[show destroy add_task]
  authorize_resource except: %i[index show]

  def index
    @user = User.find(current_user.id)
    @user.teamleader? ? @task_pools = @user.task_pools.uniq : @task_pools = @user.assigned_task_pools.uniq
  end

  def show
    @tasks_pool = TaskPool.find(params[:id])
    @tasks = @tasks_pool.tasks
  end

  def create
    @task_pool = TaskPool.create!(name: params[:name], team_leader_id: current_user.id)

    redirect_to task_pools_path
  end

  def destroy
    @task_pool.destroy
    redirect_to task_pools_path
  end

  def add_task
    @task = @task_pool.tasks.create!(task_params)
    redirect_to task_pool_path(@task_pool)
  end

  private

  def find_task_pool
    @task_pool = TaskPool.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :type, :description, :deadline, :user_ids).merge(progress: 'to_do')
  end
end
