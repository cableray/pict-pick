class RatingsController < ApplicationController
  before_action :set_rating

  def create
    vote_attrs={user_id:current_user.id,rating_id:@rating.id}
    @vote = Vote.find_or_initialize_by(vote_attrs)

    respond_to do |format|
      if @vote.update(vote_params)
        binding.pry
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
