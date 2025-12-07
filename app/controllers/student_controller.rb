#This class is used to ensure that all inherited controllers have the before_actions included in this controller
class StudentController < ApplicationController
  #This before action ensures that the user's role is Student
  before_action :ensure_student!
end
