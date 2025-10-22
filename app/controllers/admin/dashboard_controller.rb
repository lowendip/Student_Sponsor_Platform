module Admin
  class DashboardController < AdminController
    before_action :set_project, only: [:show, :edit, :update, :delete, :hide, :unhide, :renew]
    
    def index
      params[:q] = {} if params[:q].blank?
      @q = Project.all.order(created_at: :desc).ransack(params[:q])
      @projects = @q.result
      @q_name_cont = params[:q][:name_cont]
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

    def delete
      if @project.delete
        flash[:notice] = "Project Deleted"
        redirect_to admin_dashboard_path
      else
        flash[:alert] = "Failed to Delete Project"
        redirect_to root_path
      end
    end

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

    def renew
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
