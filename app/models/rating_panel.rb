class RatingPanel < ActiveRecord::Base
  belongs_to :image
  has_many :ratings
end
