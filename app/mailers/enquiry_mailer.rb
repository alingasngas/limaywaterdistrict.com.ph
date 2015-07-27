class EnquiryMailer < ActionMailer::Base
  default from: "mailer@mariwad.com.ph"

  def send_enquiry(name, email, message)
    @name = name
    @email = email
    @message = message
    mail to: 'enquiries@mariwad.com.ph',
         bcc: Rails.env.development? ? 'warrenchaudhry@gmail.com' : %w{warrenchaudhry@gmail.com louie@mariwad.com.ph},
         subject: "Customer Enquiry - #{@name}"
  end
end
