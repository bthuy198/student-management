class StudentClass < ApplicationRecord
  belongs_to :teacher
  max_paginates_per 10
  belongs_to :school
  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end
end
