#These controllers are used for making new accounts
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def new_sponsor
    @user = User.new
  end

  def new_student
    @user = User.new
  end

  #Used for creating a new student or sponsor account
  def create
    @user = User.new(user_params.merge(status:"Active"))
    if @user.save
      #Adds domains to the user (the domains are foreign keys used for searching)
        params["user"]["domains"].each do |domain|
          if domain!=""
            @user.domains << Domain.find(domain.to_i)
          end
        end
      #Sends a confirmation email to the new user
      UserMailer.registration_confirmation(@user).deliver_now
      redirect_to sign_in_path, notice: "You have been sent a confirmation email"
    else
      #These render the correct views if user input validation fails
      if params["user"]["role"]=="Sponsor"
        render :new_sponsor, status: :unprocessable_entity
      elsif params["user"]["role"]=="Student"
        render :new_student, status: :unprocessable_entity
      end
    end
  end

  #This controller is linked in the confirmation email
  #It sets the user's email_confirmed to be true
  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Your email has been confirmed. Please sign in to continue."
      redirect_to sign_in_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :organization, :role, :contact, :username, :email, :password, :password_confirmation)
  end
end
