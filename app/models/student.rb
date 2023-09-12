class Student < ApplicationRecord
	has_many :grades
	accepts_nested_attributes_for :grades
end
