require 'spec_helper'

describe RatingPanel do
  describe "Factory" do
    subject {create :rating_panel}
    it {should be_valid}
  end
end
