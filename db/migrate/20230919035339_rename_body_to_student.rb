class RenameBodyToStudent < ActiveRecord::Migration[7.0]
  def change
    rename_column :students, :name, :firstname
  end
end
