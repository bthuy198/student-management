# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!, only: [:index]
  # def after_sign_in_path_for(_resouce)
  #   userpage_path
  # end
end
