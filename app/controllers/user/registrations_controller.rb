class Devise::RegistrationsController < UsersController
  protected

  def after_sign_up_path_for(resource)
    return unless resource.save

    UserMailer.with(user: resource).welcome_email.deliver_later
  end
end
