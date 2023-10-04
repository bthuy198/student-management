class School < ApplicationRecord
  has_many :teachers
  has_many :student_classes
  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[student_classes teachers]
  end
end
