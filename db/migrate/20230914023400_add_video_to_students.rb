class AddVideoToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :video, :string
  end
end
