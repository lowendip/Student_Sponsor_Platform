class PagesController < ApplicationController

  def index
    @projects = Project.joins(:images_blobs).where(active_storage_blobs: { content_type: ["image/png", "image/jpeg"] }).order(created_at: :desc).limit(9)
  end
end
