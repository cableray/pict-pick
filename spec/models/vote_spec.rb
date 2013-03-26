require 'spec_helper'

describe Vote do
  describe "Factory" do
    subject {create :vote}
    it {should be_valid}
  end
  describe "validations" do
    it {should validate_numericality_of(:value)}
  end
end
