class Image < ActiveRecord::Base
  has_many :ratings
  has_attached_file :image
end
