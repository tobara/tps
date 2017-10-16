class UserMailer < ActionMailer::Base
  default :from => "application_name@domain.com"

  def registration_confirmation(user)
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Registration Confirmation for Awesome App", :body => "http://localhost:9393/#{user.confirm_token}/confirm_email/")
  end
end
