# frozen_string_literal: true

class Grade < ApplicationRecord
  belongs_to :student
  validates :score, :semester, numericality: { only_integer: true, in: 0..10 }
end
