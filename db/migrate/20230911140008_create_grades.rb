# frozen_string_literal: true

class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.string :subject
      t.integer :score
      t.integer :semester
      t.string :comments
      t.references :student

      t.timestamps
    end
  end
end
