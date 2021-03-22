require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe NaversController, type: :controller do
  let(:navers) { create_list(:navers, 4) }
  describe 'GET' do
    context 'index' do
      before do
        user = build(:user)
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        # This will add a valid token for `user` in the `Authorization` header
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge!(auth_headers)
        get :index
      end
      it 'should return list navers' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).count).to eq(4)
      end
    end
  end
end
