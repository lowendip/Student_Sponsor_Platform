class SessionsController < ApplicationController
  
  auto_session_timeout_actions
 
  #This is used to access the main sign in page
  def index
    redirect_to sign_in_path
  end
  
  def new
  end

  #This allows the user to log int to their account
  #It verifies that their password is correct, their email is confirmed, and their account is not disabled
  def create
    user = User.find_by(username: params[:username])
    #Verifies a user exists with the given username and their password is correct
    if user && user.authenticate(params[:password])
      #Verifies that the user's email is confirmed
      if user.email_confirmed
        #Verifies that the user's account is active (not disabled by an admin)
        if user.status == "Active"
          #Sets the session user_id, this is used by the application controller to determine current_user
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

  #This logs the user out
  def delete
    current_user = nil
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end
end
