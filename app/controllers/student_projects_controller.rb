#The pages corresponding to these controllers are accessible only to logged in users
class StudentProjectsController < ApplicationController
    before_action :ensure_logged_in
    
    #Displays all visible (not hidden), active, student projects that are not expired
    #These projects are ordered by most recently updated
    def index
      params[:q] = {} if params[:q].blank?
      #Ensures the projects belong to students and are active (the user's account is not disabled)
      project_ids = Project.belongs_to_student.active_projects
      #Checks to see if the projects are past the expiration date and if they are supposed to be visible, orders by most recently updated
      @q = Project.where(id:project_ids).where("expiration >= ?", DateTime.now).where(status:"Visible").order(updated_at: :desc).distinct.ransack(params[:q])
      @projects = @q.result
      @q_name_cont = params[:q][:name_cont] #Search by project name
      @q_user_name_cont = params[:q][:user_name_cont] #Search by user's name
      @q_domains_id_in = params[:q][:domains_id_in] #Search by domain search tag
      @domains = Domain.all
    end
    
    def show
      if Project.where(id:params[:id]).exists?
        @project = Project.find(params[:id])
      else
        flash[:alert] = "Cannot find project"
        redirect_to root_path
      end
    end

    private
    
    def project_params
      params.require(:project).permit(:name, :short_desc, :long_desc)
    end
  end
