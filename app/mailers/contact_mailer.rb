class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact

    mail to: ENV["SMTP_USER_NAME"], subject: "お問い合わせの受付"
  end
end
