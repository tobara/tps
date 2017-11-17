class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  default from: 'application_name@domain.com'
end
