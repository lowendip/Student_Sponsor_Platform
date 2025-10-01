class SponsorController < ApplicationController
  #before_action :authenticate_user!
  before_action :ensure_sponsor!
end
