module Admin
  class DashboardController < AdminController
    before_action :set_project, only: [:show, :edit, :update, :destroy, :hide, :unhide, :renew]
    
    #This index page contains all projects ordered by the most recently created projects
    def index
      params[:q] = {} if params[:q].blank?
      @q = Project.all.joins(:user).order(created_at: :desc).ransack(params[:q])
      @projects = @q.result
      @q_name_cont = params[:q][:name_cont]
      @q_user_name_cont = params[:q][:user_name_cont]
      @q_user_role_eq = params[:q][:user_role_eq]
    end
    
    def show
    end

    def edit
    end

    def update
      if @project.update(project_params)
        flash[:notice] = "Project Updated"
        redirect_to admin_dashboard_path
      else
        flash[:alert] = "Failed to Update Project"
        redirect_to root_path
      end
    end

    def destroy
      if @project.destroy
        flash[:notice] = "Project Destroyed"
        redirect_to admin_dashboard_path
      else
        flash[:alert] = "Failed to Destroy Project"
        redirect_to admin_dashboard_path
      end
    end

    #Makes the project invisible on the public pages
    def hide
      @project.update(status: "Hidden")
      if @project.save
        redirect_to admin_dashboard_path
        flash[:notice] = "Project Hidden"
      else
        redirect_to admin_dashboard_path
        flash[:notice] = "Failed To Hide"
      end
    end

    #Makes the project visible on the public pages
    def unhide
      @project.update(status: "Visible")
      if @project.save
        redirect_to admin_dashboard_path
        flash[:notice] = "Project Visible"
      else
        redirect_to admin_dashboard_path
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
        redirect_to admin_dashboard_path
        flash[:notice] = "Project Renewed"
      else
        redirect_to admin_dashboard_path
        flash[:notice] = "Failed To Renew"
      end
    end

    private
    
    def set_project
      @project = Project.find_by(id: params[:id])
      if !@project
        flash[:alert] = "Cannot find project"
        redirect_to admin_dashboard_path
      end
    end

    def project_params
      params.require(:project).permit(:name, :short_desc, :long_desc, :domains)
    end
  end
end
