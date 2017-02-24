class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :project_owner

  def project_owner(project)

    return current_user.present? && current_user.id == project.owner_id
  end


  

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
