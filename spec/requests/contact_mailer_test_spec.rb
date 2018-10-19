require 'rails_helper'

describe 'POST /contact', type: :request do
  context 'when valid params are provided' do
    before do
      post '/v1/contact',
        params: { email: Faker::Internet.email, message: 'Hello, world!' }.to_json,
        headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when valid params are provided' do
    before do
      post '/v1/contact',
        params: { }.to_json,
        headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end