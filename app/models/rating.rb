class Rating < ActiveRecord::Base
  belongs_to :rating_panel
  has_many :votes
  validates_uniqueness_of :name, scope: :rating_panel_id

  def mean(refresh=false)
    if votes(refresh).count == 0 then
      return 0
    else
      vote_values.sum.to_f / votes.count
    end
  end

  def has_votes?
    votes.present?
  end


  def vote_values(refresh=false)
    votes(refresh).map(&:value)
  end

  def image
    rating_panel.image
  end

end
