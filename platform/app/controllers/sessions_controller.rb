class SessionsController < ApplicationController
  def index
    redirect_to sessions_new_path
  end
  
  def new
  end

  def create
  user = User.find_by(username: params[:username])
if user && user.authenticate(params[:password])
session[:user_id] = user.id
redirect_to root_path, notice: "Logged in successfully"
else
flash.now[:alert] = "Invalid username or password"
render :new
end
  end

  def destroy
    @current_user = nil
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end
  
end
