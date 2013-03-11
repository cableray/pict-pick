class RatingsController < ApplicationController
  before_action :set_image

  def create
    @rating = @image.ratings.build(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @image, notice: 'Rating was successfully created.' }
        format.json { render action: 'show', status: :created, location: image_rating_url(@image,@rating) }
      else
        format.html { render action: 'new' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def set_image
    @image = Image.find(params[:image_id])
  end

  def rating_params
    params.require(:rating).permit(:value)
  end

end
