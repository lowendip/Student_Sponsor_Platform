class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :app_init
  helper_method :current_user
  def app_init
  end

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

  def ensure_sponsor!
    ensure_role "Sponsor"
  end

  def ensure_admin!
    ensure_role "Admin"
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end
