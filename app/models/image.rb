class Image < ActiveRecord::Base
  has_many :rating_panels
  has_attached_file :image

  

end
