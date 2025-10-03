module Sponsor
  class ProjectsController < SponsorController 
    def index
      params[:q] = {} if params[:q].blank?
      @q = Project.where(user: current_user).ransack(params[:q])
      #@projects = Project.where(user: current_user)
      @projects = @q.result
      @q_name_cont = params[:q][:name_cont]
    end
    
    def show
      @project = Project.find(params[:id])
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params.merge(user: current_user, expiration: DateTime.now.next_year(2).to_time))
      if @project.save
        redirect_to sponsor_projects_url
      else
        redirect_to root_path
      end
    end
    
    private
    
    def project_params
      params.require(:project).permit(:name, :short_desc, :long_desc)
    end
  end
end
