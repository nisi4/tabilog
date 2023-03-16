class CreateTowns < ActiveRecord::Migration[6.1]
  def change
    create_table :towns do |t|
      t.string :town_name,null: false

      t.timestamps
    end
  end
end
