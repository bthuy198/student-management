class Teacher < ApplicationRecord
  has_many :student_classes
  belongs_to :school
  max_paginates_per 10
  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[school student_classes]
  end
end
