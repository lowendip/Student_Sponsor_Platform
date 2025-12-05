#This class is used to ensure that all inherited controllers have the before_actions included in this controller
class AdminController < ApplicationController
  #This before action ensures that the user's role is Admin
  before_action :ensure_admin!
end
