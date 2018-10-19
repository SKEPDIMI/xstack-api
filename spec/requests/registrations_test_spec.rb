require 'rails_helper'
include ActionController::RespondWith

describe 'POST /auth', type: :request do
  context 'Valid credentials are provided' do
    before do
      sign_up
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(:success)
    end
    it 'should have returned user' do
      body = JSON.parse(response.body)

      expect(body['data']).to be_present
    end
    it 'should have created user' do
      expect{ sign_up }.to change { User.count }.by 1
    end
    it 'should provide authentication token' do
      expect(response.headers['access-token']).to be_present
      expect(response.headers['token-type']).to be_present
      expect(response.headers['client']).to be_present
      expect(response.headers['uid']).to be_present
      expect(response.headers['expiry']).to be_present
    end
  end
  context 'when invalid credentials' do
    context 'when email' do
      before do
        sign_up email: 'fakeemail'
      end
      it 'should return  status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'when password' do
      before do
        sign_up password: ''
      end
      it 'should return  status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  context 'when user already exists' do
    let (:user) { create(:user) }
    before do
      sign_up email: user.email, password: user.password
    end

    it 'should return status code 4xx' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  context 'when unsanitized' do
    context 'email is provided' do
      before do
        custom_sign_up({ email: malicious_text })
      end
      it 'should return status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'name is provided' do
      before do
        custom_sign_up({ name: malicious_text })
      end

      it 'should have an empty name' do
        body = JSON.parse(response.body)
        
        expect(body['data']['name']).to be_nil
      end
    end
    context 'nickname is provided' do
      before do
        custom_sign_up({ nickname: malicious_text })
      end

      it 'should have an empty name' do
        body = JSON.parse(response.body)
        
        expect(body['data']['nickname']).to be_nil
      end
    end
    context 'bio is provided' do
      before do
        custom_sign_up({ bio: malicious_text })
      end

      it 'should have an empty name' do
        body = JSON.parse(response.body)
        
        expect(body['data']['bio']).to be_nil
      end
    end
    context 'description is provided' do
      before do
        custom_sign_up({ description: malicious_text })
      end

      it 'should have an empty name' do
        body = JSON.parse(response.body)
        
        expect(body['data']['description']).to be_nil
      end
    end
    context 'url is provided' do
      before do
        custom_sign_up({ url: malicious_text })
      end

      it 'should have an empty name' do
        body = JSON.parse(response.body)
        
        expect(body['data']['url']).to be_nil
      end
    end
  end
  def sign_up(args = {})
    email = args[:email] || Faker::Internet.email
    password = args[:password] || Faker::Internet.password

    post '/auth',
      params: { email: email, password: password, password_confirmation: password }.to_json,
      headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
  end
  def custom_sign_up(args = {})
    args[:email] ||= Faker::Internet.email
    args[:password] ||= Faker::Internet.password
    args[:password_confirmation] = args[:password]

    post '/auth',
      params: args.to_json,
      headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
  end
  def malicious_text
    [
      '<script>aler("Hacked!")</script>',
      '<script href="xss.com"></script>',
      '<a href="hello_world.html"></a>',
      '<script></script>',
    ].sample
  end
end