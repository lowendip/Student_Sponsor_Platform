class StudentsController < ApplicationController 
    def index
      params[:q] = {} if params[:q].blank?
      @q = User.where(role: "Student").ransack(params[:q])
      @users = @q.result
      @q_name_cont = params[:q][:name_cont]
      @q_domains_id_in = params[:q][:domains_id_in]
      @domains = Domain.all
    end
  end
