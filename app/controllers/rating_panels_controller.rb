class RatingPanelsController < ApplicationController
  before_action :set_image
  before_action :set_rating_panel, except: [:index,:new]

  private

  def set_image
    @image=Image.find(params[:image_id]).includes(:rating_panels)
  end
  def set_rating_panel

  end
end
