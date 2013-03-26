class Vote < ActiveRecord::Base
  belongs_to :rating

  validates_numericality_of :value
end
