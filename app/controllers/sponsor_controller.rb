#This class is used to ensure that all inherited controllers have the before_actions included in this controller
class SponsorController < ApplicationController
  #This before action ensures that the user's role is Sponsor
  before_action :ensure_sponsor!
end
