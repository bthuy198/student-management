# frozen_string_literal: true

class Grade < ApplicationRecord
  belongs_to :student
  validates :score, :semester, numericality: { only_integer: true, in: 0..10 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[comments created_at id score semester student_id subject]
  end
end
