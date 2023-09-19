class AddFirstnameToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :firstname, :string
  end
end
