class TestMailer < ActionMailer::Base
  default from: "mailer@mariwad.com.ph"

  def test_email(recipient)
    @recipient = recipient
    mail to: recipient, subject: 'Test Email'
  end
end
