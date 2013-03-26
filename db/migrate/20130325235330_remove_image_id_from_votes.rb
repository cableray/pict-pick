class RemoveImageIdFromVotes < ActiveRecord::Migration
  def change
    remove_reference :votes, :image, index: true
  end
end
