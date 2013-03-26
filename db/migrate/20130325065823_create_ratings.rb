class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :name
      t.text :description
      t.belongs_to :rating_panel, index: true

      t.timestamps
    end
  end
end
