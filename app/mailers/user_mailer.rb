class UserMailer < ApplicationMailer
  default from: 'bitmakergroup@gmail.com'

  def pledge_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank you for the pleging!')
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank you for signing up!')
  end

  def create_project_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank you for creating a project!')
  end

end
