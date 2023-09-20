# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'bichthuydangthi198@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://127.0.0.1:3000/users/sign_in'
    mail(to: 'thuy@gmail.com', subject: 'Welcome to My Website')
  end
end
