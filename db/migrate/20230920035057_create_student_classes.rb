class CreateStudentClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :student_classes do |t|
      t.belongs_to :teacher, index: true
      t.string :name

      t.timestamps
    end
  end
end
