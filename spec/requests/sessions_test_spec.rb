require 'rails_helper'
include ActionController::RespondWith

describe 'POST /auth/sign_in', type: :request do
  let(:user) { create(:user) }

  context 'When correct credentials are sent' do
    before do
      # LOGIN
      post '/auth/sign_in',
        params: { email: user.email, password: user.password }.to_json,
        headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
    it 'gives you an access-token' do
      expect(response.headers['access-token']).to be_present
    end
  end
  context 'When incorrect credentials are sent' do
    before do
      post '/auth/sign_in',
        params: { email: Faker::Internet.email, password: Faker::Internet.password }.to_json,
        headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

describe 'GET /auth/validate_token', type: :request do
  let(:user) { create(:user) }

  context 'when correct auth_params are sent' do
    before do
      # LOGIN
      post '/auth/sign_in',
        params: { email: user.email, password: user.password }.to_json,
        headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
      
      # VALIDATE TOKEN
      get '/auth/validate_token',
        headers: get_auth_params_from_login_response_headers(response)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
    it 'should contain user data' do
      body = JSON.parse(response.body)
      user = body['data']
      expect(user['email']).to be_present
      expect(user['uid']).to be_present
    end
  end
  def get_auth_params_from_login_response_headers(response)
    {
      'access-token' => response.headers['access-token'],
      'client' => response.headers['client'],
      'uid' => response.headers['uid'],
      'expiry' => response.headers['expiry'],
      'token_type' => response.headers['token-type']
    }
  end
end