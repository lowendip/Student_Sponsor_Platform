class PasswordResetController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      token = @user.generate_token_for(:password_reset)
      UserMailer.with(user: @user, password_reset_token: token).password_reset.deliver_now
      redirect_to root_path, notice: "Email sent with password reset instructions"
    else
      flash.now[:notice] = "No user found with that email address"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by_token_for(:password_reset, params[:password_reset_token])
    if @user.nil?
      flash[:notice] = "Invalid token. Try again by requesting a new password reset link."
      redirect_to password_reset_new_path
    end
  end

  def update
    @user = User.find_by_token_for(:password_reset, params[:password_reset_token])
    if @user.nil?
      flash[:notice] = "Invalid token. Try again by requesting a new password reset link."
      redirect_to password_reset_new_path
    elsif @user.update(password_reset_params)
      redirect_to sign_in_path, notice: "Password has been successfully reset"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_reset_params
    params.require(:password_reset).permit(:password, :password_confirmation)
  end

end
