# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :require_team_leader, only: %i[destroy]
  authorize_resource except: %i[index show update]

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update!(member_update)

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @task = Task.find(params[:id])
    task_pool = @task.task_pool
    @task.destroy

    redirect_to task_pool_path(task_pool)
  end

  def add_collaborator
    @task = Task.find(params[:id])

    if params[:feature_request]
      @new_member = User.find(params[:feature_request][:user_ids].to_i)
    elsif params[:bug_report]
      @new_member = User.find(params[:bug_report][:user_ids].to_i)
    elsif params[:marketing_campaign]
      @new_member = User.find(params[:marketing_campaign][:user_ids].to_i)
    end

    @task.users << @new_member unless @task.users.include?(@new_member)

    redirect_back(fallback_location: root_path)
  end

  def remove_collaborator
    @task = Task.find(params[:id])
    collaborator = User.find(params[:user_id].to_i)
    @task.users.delete(collaborator)
    
    redirect_back(fallback_location: root_path)
  end

  private

  def task_params
    params.require(:task).permit(:type, :title, :description, :deadline, :progress, :attachment)
  end

  def member_update
    params.require(resource_type).permit(:progress, :attachment)
  end

  def resource_type
    if params.key?('bug_report')
      'bug_report'
    elsif params.key?('feature_request')
      'feature_request'
    elsif params.key?('marketing_campaign')
      'marketing_campaign'
    end
  end

  def require_team_leader
    redirect_to(root_path) unless current_user&.teamleader?
  end
end
