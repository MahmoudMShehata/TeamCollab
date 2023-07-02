# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :root

  def after_sign_in_path_for(_users)
    current_user.teamleader? ? dashboard_path : task_pools_path
  end

  def root
    flash[:error] = 'You have to be logged in.'

    redirect_to root_path unless current_user
  end
end
