module Admin
  class UsersController < AdminController
    before_action :set_user, only: [:edit, :update, :delete, :disable, :reactivate]
    
    def index
      params[:q] = {} if params[:q].blank?
      @q = User.all.order(created_at: :desc).ransack(params[:q])
      @users = @q.result
      @q_name_cont = params[:q][:name_cont]
      @q_username_cont = params[:q][:username_cont]
      @q_role_eq = params[:q][:role_eq]
    end
    
    def edit
    end

    def update
      if @user.update(project_params)
        flash[:notice] = "User Updated"
        redirect_to admin_users_path
      else
        flash[:alert] = "Failed to Update User"
        redirect_to root_path
      end
    end

    def delete
      if @user.delete
        flash[:notice] = "User Deleted"
        redirect_to admin_users_path
      else
        flash[:alert] = "Failed to Delete User"
        redirect_to root_path
      end
    end

    def disable
      @user.update(status: "Disabled")
      if @user.save
        redirect_to admin_users_path
        flash[:notice] = "User Account Disabled"
      else
        redirect_to admin_users_path
        flash[:notice] = "Failed To Disable User Account"
      end
    end

    def reactivate
      @user.update(status: "Active")
      if @user.save
        redirect_to admin_users_path
        flash[:notice] = "User Account Active"
      else
        redirect_to admin_dashboard_path
        flash[:notice] = "Failed To Make User Account Active"
      end
    end

    private
    
    def set_user
      @user = User.find_by(id: params[:id])
      if !@user
        flash[:alert] = "Cannot Find User"
        redirect_to admin_users_path
      end
    end

    def project_params
      params.require(:user).permit(:name, :username, :organization, :status, :role)
    end
  end
end
