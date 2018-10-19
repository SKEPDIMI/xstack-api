require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  describe 'POST user_img' do
    context 'without authentication' do
      it 'returns status code 401' do
        post :user_img
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
