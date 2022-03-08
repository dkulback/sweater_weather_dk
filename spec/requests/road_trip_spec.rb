require 'rails_helper'

RSpec.describe 'API roadtrips' do
  let(:headers) { { "Content-Type": 'application/json', "Accept": 'application/json' } }
  let(:valid_body) { { origin: 'denver,co', destination: 'Pueblo,co', api_key: 'lx7HrdFFTzSDKXv64chdGwtt' } }
  let(:invalid_destination) { { origin: 'denver,co', destination: 'Germany', api_key: 'lx7HrdFFTzSDKXv64chdGwtt' } }
  let(:invalid_body) { { origin: 'denver,co', destination: 'Pueblo,co', api_key: '12345' } }
  describe 'POST api/v1/road_trip' do
    context 'when params are valid' do
      it 'returns a user json and status 200' do
        user = User.create!(email: 'user_email@gmail.com', password: '12345', password_confirmation: '12345')
        user.update!(api_key: 'lx7HrdFFTzSDKXv64chdGwtt')
        VCR.use_cassette('current_road_trip') do
          post api_v1_road_trip_path, headers: headers, params: JSON.generate(valid_body)

          road_trip = JSON.parse(response.body, symbolize_names: true)
          expect(road_trip).to have_key(:data)
          expect(road_trip[:data]).to have_key(:id)
          expect(road_trip[:data]).to have_key(:type)
          expect(road_trip[:data]).to have_key(:attributes)

          expect(road_trip[:data][:id]).to eq(nil)
          expect(road_trip[:data][:type]).to be_a(String)
          expect(road_trip[:data][:attributes]).to be_a(Hash)

          expect(road_trip[:data][:attributes]).to have_key(:start_city)
          expect(road_trip[:data][:attributes]).to have_key(:end_city)
          expect(road_trip[:data][:attributes]).to have_key(:travel_time)
          expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)

          expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
          expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
          expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
          expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)

          expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
          expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)

          expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
          expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
          expect(response).to have_http_status(200)
        end
      end
    end
    context 'when api_key is invalid' do
      it 'returns unprocessable entity, status 401, unauthorized' do
        user = User.create!(email: 'user_email@gmail.com', password: '12345', password_confirmation: '12345')
        user.update!(api_key: 'lx7HrdFFTzSDKXv64chdGwtt')
        post api_v1_road_trip_path, headers: headers, params: JSON.generate(invalid_body)

        expect(response).to have_http_status(401)
        expect(response.body).to match(/Invalid or missing api key/)
      end
    end
    context 'when road trip is not possible ' do
      it 'returns impossible trip response status 200' do
        user = User.create!(email: 'user_email@gmail.com', password: '12345', password_confirmation: '12345')
        user.update!(api_key: 'lx7HrdFFTzSDKXv64chdGwtt')
        VCR.use_cassette('invalid_destination') do
          post api_v1_road_trip_path, headers: headers, params: JSON.generate(invalid_destination)

          road_trip = JSON.parse(response.body, symbolize_names: true)
          expect(road_trip[:data][:attributes]).to have_key(:travel_time)
          expect(road_trip[:data][:attributes][:travel_time]).to eq('Impossible')
          expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
          expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
