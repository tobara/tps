class UserMailer < ActionMailer::Base
  default :from => "application_name@domain.com"

  def registration_confirmation(request, user)
    @user = user
    @url = "http://#{request.host}:#{request.port}/#{user.confirm_token}/confirm_email/"

    mail(
      to: "#{user.first_name} <#{user.email}>",
      subject: "Registration Confirmation for EDS Tuition Portal",
      template: "registration_confirmation"
    ) do |format|
      format.text
      format.html
    end
  end

  def password_reset(request, user)
    @user = user
    @url = "http://@#{request.host}:#{request.port}/#{user.pass_token}/pass_email/"

    mail(
      to: "#{user.first_name} <#{user.email}>",
      subject: "Password Reset for EDS Tuition Portal",
      template: "password_reset"
    ) do |format|
      format.text
      format.html
    end
  end
end
