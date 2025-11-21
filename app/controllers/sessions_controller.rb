class SessionsController < ApplicationController
  def index
    redirect_to sign_in_path
  end
  
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.email_confirmed
        if user.status == "Active"
          session[:user_id] = user.id
          redirect_to root_path, notice: "Logged in successfully"
        else
          redirect_to root_path, notice: "Your account has been disabled and all your projects have been hidden. Please contact an admin if you believe this is a mistake."
        end
      else
        flash[:alert] = "Please confirm your email"
        redirect_to sign_in_path
      end
    else
      flash[:alert] = "Invalid username or password"
      redirect_to sign_in_path
    end
  end

  def delete
    current_user = nil
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end
  
end
