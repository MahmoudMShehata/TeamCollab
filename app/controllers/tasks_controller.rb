class TasksController < ApplicationController
  before_action :require_team_leader, only: [:create, :update, :destroy]
  authorize_resource except: [:index, :show, :update]

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)

    redirect_back(fallback_location: root_path)
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
    debugger
    @task = Task.find(params[:id])
    @new_member = User.find(params[:feature_request][:user_ids].to_i)
    @task.users << @new_member unless @task.users.include?(@new_member)

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
    if params.key?("bug_report")
      "bug_report"
    elsif params.key?("feature_request")
      "feature_request"
    elsif params.key?("marketing_campaign")
      "marketing_campaign"
    end
  end

  def require_team_leader
    redirect_to(root_path) unless current_user and current_user.teamleader?
  end
end
