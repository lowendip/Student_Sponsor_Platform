#Controls the content on the page for browsing students
#The pages corresponding to these controllers are accessible only to logged in users
class StudentsController < ApplicationController
    before_action :ensure_logged_in
    
    #Includes all users that are students and not disabled
    def index
      params[:q] = {} if params[:q].blank?
      @q = User.where(role: "Student", status: "Active").distinct.ransack(params[:q])
      @users = @q.result
      @q_name_cont = params[:q][:name_cont] #Search by name
      @q_domains_id_in = params[:q][:domains_id_in] #Search by domain search tag
      @domains = Domain.all
    end
  end
