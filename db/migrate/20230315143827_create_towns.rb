class CreateTowns < ActiveRecord::Migration[6.1]
  def change
    create_table :towns do |t|
      t.string :town_name,null: false
      t.decimal :latitude, :precision => 10, :scale => 8
      t.decimal :longitude, :precision => 10, :scale => 7

      t.timestamps
    end
  end
end
