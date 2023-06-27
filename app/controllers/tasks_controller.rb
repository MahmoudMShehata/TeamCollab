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

    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])

    if current_user.teamleader?
      @task.update(task_params)
    else
      @task.update(member_update)
    end

    # if @task.update(task_params)
    #   redirect_to @task
    # else
    #   render :edit
    # end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:type, :title, :description, :deadline, :progress, :attachment)
  end

  def member_update
    params.require(:task).permit(:progress, :attachment)
  end

  def require_team_leader
    redirect_to(root_path) unless current_user and current_user.teamleader?
  end
end
