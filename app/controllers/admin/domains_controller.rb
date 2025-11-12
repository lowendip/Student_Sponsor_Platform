module Admin
  class DomainsController < AdminController
    before_action :set_domain, only: [:edit, :update, :delete]
    
    def index
      params[:q] = {} if params[:q].blank?
      @q = Domain.all.order(created_at: :desc).ransack(params[:q])
      @domains = @q.result
      @q_name_cont = params[:q][:name_cont]
    end
    
    def edit
    end

    def update
      if @domain.update(domain_params)
        flash[:notice] = "Domain Updated"
        redirect_to admin_domains_path
      else
        flash[:alert] = "Failed to Update Domain"
        redirect_to root_path
      end
    end

    def delete
      if @domain.delete
        flash[:notice] = "Domain Deleted"
        redirect_to admin_domains_path
      else
        flash[:alert] = "Failed to Delete Domain"
        redirect_to root_path
      end
    end

    def new
      @domain = Domain.new
    end

    def create
      @domain = Domain.new(domain_params)
      if @domain.save
        flash[:notice] = "Domain Created"
        redirect_to admin_domains_url
      else
        flash[:alert] = "Failed to Save"
        redirect_to root_path
      end
    end

    private
    
    def set_domain
      @domain = Domain.find_by(id: params[:id])
      if !@domain
        flash[:alert] = "Cannot Find Domain"
        redirect_to admin_domains_path
      end
    end

    def domain_params
      params.require(:domain).permit(:name)
    end
  end
end
