class Rating < ActiveRecord::Base
  belongs_to :image
  
  validates_numericality_of :value
end
