class SponsorProjectsController < ApplicationController 
    def index
      params[:q] = {} if params[:q].blank?
      @q = Project.where("expiration >= ?", DateTime.now).where(status:"Visible").order(updated_at: :desc).ransack(params[:q])
      @projects = @q.result
      @q_name_cont = params[:q][:name_cont]
      @q_domains_id_in = params[:q][:domains_id_in]
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
