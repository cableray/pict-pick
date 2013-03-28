class RatingsController < ApplicationController
  before_action :set_rating

  def create
    @vote = @rating.votes.build(vote_params)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to :back, notice: 'Vote Submitted.' }
        format.json { render action: 'show', status: :created, location: rating_url(@rating) }
      else
        format.html { render action: 'new' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def set_rating
    @rating = Rating.find(params[:rating_id]||params[:id])
  end

  def vote_params
    params.require(:vote).permit(:value)
  end

end
