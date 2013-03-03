class Image < ActiveRecord::Base
  has_many :ratings
  has_attached_file :image

  def rating(refresh=false)
    if ratings(refresh).count == 0 then
      return 0
    else
      rating_values.sum.to_f / ratings.count
    end
  end

  def rated?
    ratings.present?
  end


  def rating_values(refresh=false)
    ratings(refresh).map(&:value)
  end

end
