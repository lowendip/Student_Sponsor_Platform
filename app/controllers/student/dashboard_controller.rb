#These are the dashboard action available to students
#These actions allow users to manage their projects and their profile/account
#This inherits from sponsor controller so only students can use these controllers
module Student
  class DashboardController < StudentController
    before_action :set_project, only: [:show, :edit, :update, :destroy, :hide, :unhide, :renew]
    
    #Displays all projects that belong to the current_user ordered by the most recently created
    def index
      params[:q] = {} if params[:q].blank?
      @q = Project.where(user: current_user).order(created_at: :desc).ransack(params[:q])
      @projects = @q.result
      @q_name_cont = params[:q][:name_cont] #Search by project name
    end
    
    #Used for viewing projects
    def show
    end

    #Used for making a new project
    def new
      @project = Project.new
    end

    #Used for creating new projects
    def create
      #Creates the new project including the current user and an expiration date that is 2 years from now
      @project = Project.new(project_params.merge(user: current_user, expiration: DateTime.now.next_year(2).to_time))
      #Adds the domains to the project (the domains are foreign keys used for searching)
      params["project"]["domains"].each do |domain|
        if domain!=""
          @project.domains << Domain.find(domain.to_i)
        end
      end
      #Saves the project if possible
      if @project.save
        flash[:notice] = "Project Created"
        redirect_to student_dashboard_url
      else
        render :new, status: :unprocessable_entity
      end
    end

    #Used for editing projects
    def edit
    end

    #Used for updating projects
    def update
      if @project.update(project_params)
        #Adds domains to the project (the domains are foreign keys used for searching) or clears the domains if there are none in params
      params["project"]["domains"].each do |domain|
        if domain!=""
          @project.domains << Domain.find(domain.to_i)
        else
          @project.domains.clear
        end
      end
        flash[:notice] = "Project Updated"
        redirect_to student_dashboard_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    #Used for deleting projects and all their attachments
    def destroy
      if @project.destroy
        flash[:notice] = "Project Deleted"
        redirect_to student_dashboard_path
      else
        flash[:alert] = "Failed to Delete Project"
        redirect_to root_path
      end
    end

    #Hides the project removing it from public pages
    def hide
      @project.update(status: "Hidden")
      if @project.save
        redirect_to student_dashboard_path
        flash[:notice] = "Project Hidden"
      else
        redirect_to student_dashboard_path
        flash[:notice] = "Failed To Hide"
      end
    end

    #Unhides the project making it once again visible on public pages
    def unhide
      @project.update(status: "Visible")
      if @project.save
        redirect_to student_dashboard_path
        flash[:notice] = "Project Visible"
      else
        redirect_to student_dashboard_path
        flash[:notice] = "Failed To Make Visible"
      end
    end

    #Sets the expiration date to two years from now
    #If the current date is past the expiration date the project will not be visible
    def renew
      #The project will be set to hidden after renewal if it has alreday expired
      if @project.expiration < DateTime.now
        @project.update(status: "Hidden")
      end
      @project.update(expiration: DateTime.now.next_year(2).to_time)
      if @project.save
        redirect_to student_dashboard_path
        flash[:notice] = "Project Renewed"
      else
        redirect_to student_dashboard_path
        flash[:notice] = "Failed To Renew"
      end
    end

    #Used by the user to edit the current_user's account
    def edit_profile
      @user = current_user
    end

    #Used by the user to update the current_user's account
    def update_profile
      @user = current_user
      if @user.update(user_params)
        #Adds domains to the user (the domains are foreign keys used for searching) or clears the domains if there are none in params
        params["user"]["domains"].each do |domain|
          if domain!=""
            @user.domains << Domain.find(domain.to_i)
          else
            @user.domains.clear
          end
        end
        flash[:notice] = "Profile Updated"
        redirect_to student_dashboard_path
      else
        render :edit_profile, status: :unprocessable_entity
      end
    end

    private
    
    def set_project
      @project = Project.find_by(id: params[:id], user: current_user)
      if !@project
        flash[:alert] = "Cannot find project"
        redirect_to student_dashboard_path
      end
    end

    #There are two sets of params, one set is used for managing projects and the other is used for the current user's account
    def project_params
      params.require(:project).permit(:name, :short_desc, :long_desc, :domains, :url, images:[])
    end

    def user_params
      params.require(:user).permit(:name, :username, :contact, :domains)
    end
  end
end
