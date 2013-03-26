class AddRatingIdToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :rating, index: true
  end
end
