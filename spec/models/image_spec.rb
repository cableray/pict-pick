require 'spec_helper'

describe Image do
  describe "Factory" do
    subject {create :image}
    it {should be_valid}
  end

  
end
