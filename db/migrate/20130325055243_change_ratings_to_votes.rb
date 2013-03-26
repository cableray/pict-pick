class ChangeRatingsToVotes < ActiveRecord::Migration
  def change
    rename_table :ratings, :votes
  end
end
