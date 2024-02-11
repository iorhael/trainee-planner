# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAIL_USER')
  layout 'mailer'
end
