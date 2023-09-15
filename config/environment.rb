# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
require 'carrierwave/orm/activerecord'
require File.expand_path('application', __dir__)
