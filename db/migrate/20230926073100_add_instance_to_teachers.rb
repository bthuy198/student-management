class AddInstanceToTeachers < ActiveRecord::Migration[7.0]
  def self.up
    add_column :teachers, :school_id, :integer
  end

  def self.down
    remove_column :teachers, :school_id
  end
end
