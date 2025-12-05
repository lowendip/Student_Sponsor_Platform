class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :app_init
  helper_method :current_user

  def app_init
  end

  #This function ensures that the current_user is role and otherwise redirects back to the root_path
  def ensure_role(role)
    if current_user
      if current_user.role != role
        flash[:error] = "Access denied"
        redirect_to root_path
        false
      else
        true
      end
    else
      flash[:error] = "Session expired"
      redirect_to sessions_path
      false
    end
  end

  #Ensures the current_user's role is Sponsor
  def ensure_sponsor!
    ensure_role "Sponsor"
  end

  #Ensures the current_user's role is Admin
  def ensure_admin!
    ensure_role "Admin"
  end

  #Ensures the current_user's role is Student
  def ensure_student!
    ensure_role "Student"
  end

  def ensure_logged_in
    if current_user.nil?
      flash[:error] = "Make an account or log in to access this page"
      redirect_to sign_in_path
    end
  end

  private

  #Helper function to make accessing the current_user more convenient
  #Sets the current_user to the session[:user_id]
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end
