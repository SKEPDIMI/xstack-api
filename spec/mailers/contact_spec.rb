require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  let(:data) { {
    'email' => 'diaz.john312@gmail.com',
    'name' => 'Jonathan Diaz',
    'services' => 'Mobile Development',
    'phone' => '1234567890',
    'message' => 'Hello, world!'
  } }
  describe 'when sending email directly' do
    let! (:mail) { ContactMailer.contact_email data }

    it 'renders the headers' do
      expect(mail.subject).to eq("Contact email from #{data['name']} through XSTACK")
      expect(mail.to).to eq([ENV['GMAIL_USERNAME']])
      expect(mail.from).to eq([data['email']])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include("Email from #{data['email']}")
    end
    
    it 'sends the email' do
      expect { mail.deliver_now }
        .to change { ActionMailer::Base.deliveries.count }.by 1
    end
  end
end
