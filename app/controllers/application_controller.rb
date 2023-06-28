class ApplicationController < ActionController::Base
  before_action :root

  def after_sign_in_path_for(users)
    dashboard_path
  end

  def root
    flash[:error] = "You must be logged in to access this page"
    
    redirect_to root_path unless current_user
  end
end
