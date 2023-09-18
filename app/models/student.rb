# frozen_string_literal: true

require 'carrierwave/orm/activerecord'
class Student < ApplicationRecord
  acts_as_paranoid
  has_many :grades
  validates :name, presence: true
  accepts_nested_attributes_for :grades, update_only: true
  mount_uploader :avatar, AvatarUploader
  mount_uploader :video, VideoUploader
  mount_uploader :audio, AudioUploader
  # serialize :avatar, JSON
  max_paginates_per 10
  scope :search_by_name, ->(key) { where('name like ?', "%#{key}%") }

  # scope :pagination, ->(result_per_page, start) {where("name like ?".limit(result_per_page).offset(start), key)}
  # def self.search_by_name(current_page, key)
  # 	start = @results_per_page * (current_page - 1)
  # 	if key
  # 		where("name like ? limit ? offset ?", "%#{key}%", @results_per_page.to_i, start.to_i )
  # 	else
  # 		where("name like ? limit ? offset ?", "%%", @results_per_page.to_i, start.to_i )
  # 	end
  # end
end
