require 'spec_helper'

describe RatingsController do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ImagesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "POST create" do
    before do
      @user=create(:user)
      @rating=create(:rating)
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end
    %w[json html].each do |format|
      context "with format #{format}" do
        context "with valid params" do
          context "when user hasn't voted yet" do
            before do
              Vote.where(rating_id:@rating.id,user_id:@user.id).delete_all
            end
            it "creates a new vote for the rating" do
              sign_in @user

              expect {
                post :create, {vote: attributes_for(:vote), rating_id: @rating.id, format:format}, valid_session
              }.to change{@rating.votes.count}.by(1)
            end
          end
          context "when user has already voted" do
            before do
              @vote = Vote.create_with( attributes_for(:vote, value: 10) ).find_or_create_by!(rating_id:@rating.id,user_id:@user.id)
            end
            it "changes existing vote for the rating" do
              sign_in @user

              expect {
                post :create, {vote: attributes_for(:vote, value: 5), rating_id: @rating.id, format:format}, valid_session
              }.to change{@vote.reload.value.to_i}.to(5)
            end
          end
        end
      end
    end
  end

end
