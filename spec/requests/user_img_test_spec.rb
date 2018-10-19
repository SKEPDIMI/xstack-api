require 'rails_helper'

describe 'POST /auth' do
  context 'when valid image' do
    before do
      sign_up(image: 'me.jpg')
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
    it 'returns image url' do
      body = JSON.parse(response.body)

      expect(
        body['data']['image']['url']).not_to be_nil
    end
  end

  def sign_up(args = {})
    email = args[:email] || Faker::Internet.email
    password = args[:password] || Faker::Internet.password
    file = fixture_file_upload("#{Rails.root}/spec/image/#{args[:image]}", 'image/*') if args[:image]

    post '/auth',
      params: { email: email, password: password, password_confirmation: password, image: file },
      headers: { 'Content-Type' => 'multipart/form-data' }
  end
end