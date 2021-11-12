class ApplicationMailer < ActionMailer::Base
  require 'open-uri'
  default from: 'supports.maintenances@ngser.com', content_transfer_encoding: "quoted-printable"
  layout 'mailer'
end
