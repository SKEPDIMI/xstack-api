class ContactMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']
  
  def contact_email(data)
    @name = data['name']
    @email = data['email']
    @phone = data['phone']
    @message = data['message']
    @services = data['services']

    mail(to: 'xstack.co@gmail.com', from: @email, subject: "Contact email from #{@name} through XSTACK")
  end
end
