module DeviseWhitelist
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise.controller?
  end

  def configure_permitted_parameters
    devise.parameter.sanitizer.permit(:sign_up, keys: %i[first_name last_name about type])
    devise.parameter.sanitizer.permit(:account_update, keys: %i[first_name last_name about type])
  end
end
