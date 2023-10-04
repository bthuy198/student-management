class AddSchoolToStudentClasses < ActiveRecord::Migration[7.0]
  def self.up
    add_column :student_classes, :school_id, :integer
  end

  def self.down
    remove_column :student_classes, :school_id
  end
end
