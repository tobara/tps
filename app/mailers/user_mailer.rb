class UserMailer < ActionMailer::Base
  default :from => "application_name@domain.com"

  def registration_confirmation(user)
    mail(:to => "#{user.first_name} <#{user.email}", :subject => "Registration Confirmation for Awesome App", :body => "abc")
  end
end
