class RatingPanel < ActiveRecord::Base
  belongs_to :image
  has_many :ratings
  accepts_nested_attributes_for :ratings, allow_destroy: true
end
