class RenameNameColumnToTowns < ActiveRecord::Migration[6.1]
  def change
    rename_column :towns, :name, :town_name
  end
end
