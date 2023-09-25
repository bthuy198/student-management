# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session,
                       if: proc { |c| c.request.format =~ %r{application/json} }
  # before_action :authenticate_user!, only: [:index]
  # def after_sign_in_path_for(_resouce)
  #   userpage_path
  # end
  # before_action :configure_permitted_parameters, if: :admin_
  #
  # protected
  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up).push(:firstname, :lastname, :email, :password)
  #   devise_parameter_sanitizer.for(:account_update).push(:firstname, :lastname, :email, :password)
  # end
end
