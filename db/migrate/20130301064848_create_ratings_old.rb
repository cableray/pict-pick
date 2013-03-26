# renamed so that new ratings model can be created, this table is now 'Votes'
class CreateRatingsOld < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.decimal :value
      t.belongs_to :image, index: true

      t.timestamps
    end
  end
end
