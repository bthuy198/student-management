class AddBirthdayToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :birthday, :date
  end
end
