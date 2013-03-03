require 'spec_helper'

describe Rating do
  describe "Factory" do
    subject {create :rating}
    it {should be_valid}
  end
  describe "validations" do
    it {should validate_numericality_of(:value)}
  end
end
