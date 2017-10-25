class ApplicationMailer < ActionMailer::Base
  default from: "application_name@domain.com"
   layout 'mailer'
end
