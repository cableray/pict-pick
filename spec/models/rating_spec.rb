require 'spec_helper'

describe Rating do
  describe "Factory" do
    subject {create :rating}
    it {should be_valid}
  end

  def add_votes_to_rating(votes, rating)
    rating.tap do |rtng|
      votes.each do |vote|
        rtng.votes.create!(attributes_for(:vote,value:vote))
      end
    end
  end

  describe "#mean" do
    test_sets=[
      [0,5,10],
      [1,2,3,4]
    ]
    test_sets.each do |test_set|
      context "for vote values #{test_set.inspect}" do
        votes=test_set
        votes_avr=votes.sum.to_f/votes.size
        subject do
          add_votes_to_rating(votes,create(:rating)).mean
        end

        it {should == votes_avr}
      end
    end
    context "when no votes" do
      subject{create(:rating).mean}
      it {should == 0}
    end
  end
  describe "#vote_values" do
    test_sets=[
      [],
      [0,5,10],
      [1,2,3,4]
    ]
    test_sets.each do |test_set|
      context "for vote values #{test_set.inspect}" do
        votes=test_set
        subject do
          add_votes_to_rating(votes, create(:rating)).vote_values
        end

        it {should =~ votes}
      end
    end
  end
  describe "#has_votes?" do
    context "when rating has votes" do
      subject{add_votes_to_rating([4,5,6],create(:rating)).has_votes?}
      it {should be_true}
    end
    context "when rating lacks votes" do
      subject{add_votes_to_rating([],create(:rating)).has_votes?}
      it {should be_false}
    end
  end
end
