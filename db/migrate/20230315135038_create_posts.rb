class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,null: false
      t.integer :town_id,null: false
      t.integer :category_id,null: false
      t.string :title,null: false
      t.integer :star,null: false
      t.string :body,null: false

      t.timestamps
    end
  end
end
