class RatingPanelsController < ApplicationController
  before_action :set_image
  before_action :set_rating_panel, except: [:index,:new,:create]

  def index
  end
  def show
  end

  def new
    @rating_panel= RatingPanel.new
  end
  def edit
  end

  def create
    @rating_panel = RatingPanel.new(rating_panel_params)
    @rating_panel.image=@image

    respond_to do |format|
      if @rating_panel.save
        format.html { redirect_to [@image, @rating_panel], notice: 'Rating Panel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rating_panel }
      else
        format.html { render action: 'new' }
        format.json { render json: @rating_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rating_panel.update(rating_panel_params)
        format.html { redirect_to [@image, @rating_panel], notice: 'Rating Panel was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @rating_panel }
      else
        format.html { render action: 'new' }
        format.json { render json: @rating_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_image
    @image=Image.includes(:rating_panels).find(params[:image_id])
  end
  def set_rating_panel
    @rating_panel=RatingPanel.where(image_id: params[:image_id]).find(params[:id])
  end

  def rating_panel_params
    params.require(:rating_panel).permit(:name, :description, :image, :ratings_attributes => [:name,:description,:id,:_destroy])
  end
end
