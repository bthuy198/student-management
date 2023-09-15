class AddAudioToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :audio, :string
  end
end
