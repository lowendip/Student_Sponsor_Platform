class PagesController < ApplicationController

  def index
    #This is used to determine which projects will be displayed on the home page.
    #This is only used if the user is logged in
    #This priortizes the 9 most recent projects and it will only display projects with at least one image.
    @projects = Project.joins(:images_blobs).where(active_storage_blobs: { content_type: ["image/png", "image/jpeg"] }).order(created_at: :desc).limit(9)
  end
end
