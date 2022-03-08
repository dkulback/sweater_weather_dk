require 'rails_helper'

RSpec.describe 'API sessions' do
  let(:headers) { { "Content-Type": 'application/json', "Accept": 'application/json' } }
  let(:valid_user) { { email: 'user_email@gmail.com', password: '12345' } }
  let(:invalid_user) { { email: '', password: '' } }
  let(:bad_password) { { email: 'user_email@gmail.com', password: '1234' } }
  describe 'POST api/v1/sessions' do
    context 'when params are valid' do
      it 'returns a user json and status 200' do
        User.create!(email: 'user_email@gmail.com', password: '12345', password_confirmation: '12345')
        post api_v1_sessions_path, headers: headers, params: JSON.generate(valid_user)

        user = JSON.parse(response.body, symbolize_names: true)
        expect(user).to have_key(:data)
        expect(user[:data]).to have_key(:id)
        expect(user[:data][:attributes]).to have_key(:email)
        expect(user[:data][:attributes]).to have_key(:api_key)

        expect(user[:data][:attributes]).to_not have_key(:password)
        expect(user[:data][:attributes]).to_not have_key(:password_confirmation)

        expect(response).to have_http_status(200)
      end
    end
    context 'when user info isnt valid' do
      it 'returns unprocessable entity, status 404, error response' do
        post api_v1_sessions_path, headers: headers, params: JSON.generate(invalid_user)

        errors = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(404)
        expect(response.body).to match('Credentials are invalid!')
      end
    end
    context 'when user password doesnt match' do
      it 'returns unprocessable entity, status 400, error response' do
        User.create!(email: 'user_email@gmail.com', password: '12345', password_confirmation: '12345')
        post api_v1_sessions_path, headers: headers, params: JSON.generate(bad_password)

        errors = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(422)
        expect(response.body).to match('Invalid credentials!!')
      end
    end
  end
end
