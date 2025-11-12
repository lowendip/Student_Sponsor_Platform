# Controls the content on the page for browsing sponsors
class SponsorsController < ApplicationController 
    def index
      params[:q] = {} if params[:q].blank?
      @q = User.where(role: "Sponsor", status: "Active").ransack(params[:q])
      @users = @q.result
      @q_organization_cont = params[:q][:organization_cont]
      @q_domains_id_in = params[:q][:domains_id_in]
      @domains = Domain.all
    end
  end
