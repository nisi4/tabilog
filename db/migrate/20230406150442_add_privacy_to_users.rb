class AddPrivacyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :privacy, :integer, default: 1, null: false, limit: 1
  end
end
