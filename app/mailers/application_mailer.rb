class ApplicationMailer < ActionMailer::Base
  default from: ENV['DOMAIN_NAME']
  layout 'mailer'
end
