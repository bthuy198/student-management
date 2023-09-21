# frozen_string_literal: true

require 'carrierwave/orm/activerecord'
class Student < ApplicationRecord
  acts_as_paranoid
  has_many :grades
  # validates :name, presence: true
  accepts_nested_attributes_for :grades, update_only: true
  # validates :email, uniqueness: true
  mount_uploader :avatar, AvatarUploader
  mount_uploader :video, VideoUploader
  mount_uploader :audio, AudioUploader
  # serialize :avatar, JSON
  max_paginates_per 10
  def self.ransackable_attributes(_auth_object = nil)
    %w[firstname lastname]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['grades']
  end
end
