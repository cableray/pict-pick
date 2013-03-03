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
      @image=create(:image)
    end
    context "with valid params" do
      it "creates a new rating for the image" do
        expect {
          post :create, {rating: attributes_for(:rating), image_id: @image.id}, valid_session
        }.to change{@image.ratings.count}.by(1)
      end
    end
  end

end
