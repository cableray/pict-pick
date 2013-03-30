class Vote < ActiveRecord::Base
  belongs_to :rating
  belongs_to :user

  validates_numericality_of :value
end
