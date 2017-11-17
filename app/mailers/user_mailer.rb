class UserMailer < ActionMailer::Base
  default from: 'application_name@domain.com'

  def registration_confirmation(request, user)
    @user = user
    @url = "http://#{request.host}:#{request.port}/#{user.confirm_token}/confirm_email/"

    mail(
      to: "#{user.first_name} <#{user.email}>",
      subject: 'Registration Confirmation for EDS Tuition Portal',
      template: 'registration_confirmation'
    ) do |format|
      format.text
      format.html
    end
  end

  def reset_password(request, user)
    @user = user
    @url = "http://#{request.host}:#{request.port}/#{user.reset_token}/password_reset"

    mail(
      to: "#{user.first_name} <#{user.email}>",
      subject: 'Password Reset for EDS Tuition Portal',
      template: 'reset_password'
    ) do |format|
      format.text
      format.html
    end
  end
end
