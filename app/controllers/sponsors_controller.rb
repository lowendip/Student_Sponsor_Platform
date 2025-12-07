#Controls the content on the page for browsing sponsors
#The pages corresponding to these controllers are accessible only to logged in users
class SponsorsController < ApplicationController
    before_action :ensure_logged_in
    
    #Includes all users that are sponsors and not disabled
    def index
      params[:q] = {} if params[:q].blank?
      @q = User.where(role: "Sponsor", status: "Active").distinct.ransack(params[:q])
      @users = @q.result
      @q_organization_cont = params[:q][:organization_cont] #Search by organization
      @q_domains_id_in = params[:q][:domains_id_in] #Search by domain search tag
      @domains = Domain.all
    end
  end
