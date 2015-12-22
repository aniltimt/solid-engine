class NotifyMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def approve_email(user)
    @user = user
    #@url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Approve email for your account')
  end

  def disapprove_email(user)
    @user = user
    #@url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Dis-approve email for your account')
  end	
end
