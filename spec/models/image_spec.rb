require 'spec_helper'

describe Image do
  describe "Factory" do
    subject {create :image}
    it {should be_valid}
  end

  def add_ratings_to_image(ratings, image)
    image.tap do |img|
      ratings.each do |rating|
        img.ratings.create!(attributes_for(:rating,value:rating))
      end
    end
  end

  describe "#rating" do
    test_sets=[
      [0,5,10],
      [1,2,3,4]
    ]
    test_sets.each do |test_set|
      context "for rating values #{test_set.inspect}" do
        ratings=test_set
        ratings_avr=ratings.sum.to_f/ratings.size
        subject do
          add_ratings_to_image(ratings,create(:image)).rating
        end

        it {should == ratings_avr}
      end
    end
    context "when no ratings" do
      subject{create(:image).rating}
      it {should == 0}
    end
  end
  describe "#rating_values" do
    test_sets=[
      [],
      [0,5,10],
      [1,2,3,4]
    ]
    test_sets.each do |test_set|
      context "for rating values #{test_set.inspect}" do
        ratings=test_set
        subject do
          add_ratings_to_image(ratings, create(:image)).rating_values
        end

        it {should =~ ratings}
      end
    end
  end
  describe "#rated?" do
    context "when image has ratings" do
      subject{add_ratings_to_image([4],create(:image)).rated?}
      it {should be_true}
    end
    context "when image lacks ratings" do
      subject{add_ratings_to_image([],create(:image)).rated?}
      it {should be_false}
    end
  end
end
