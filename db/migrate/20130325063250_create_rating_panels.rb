class CreateRatingPanels < ActiveRecord::Migration
  def change
    create_table :rating_panels do |t|
      t.belongs_to :image, index: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
