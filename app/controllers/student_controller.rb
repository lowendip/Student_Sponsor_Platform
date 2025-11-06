class StudentController < ApplicationController
  before_action :ensure_student!
end
