require 'rails_helper'

RSpec.describe 'Forecast API', type: :request do
  describe 'GET /api/v1/forecast?location=denver,co' do
    let(:headers) { { "Content-Type": 'application/json', "Accept": 'application/json' } }
    let(:valid_params) { { location: 'denver,co' } }
    let(:invalid_params) { { location: '' } }
    context 'when params are valid' do
      it 'returns status code 200/json response of weather data' do
        VCR.use_cassette('denver_forecast_2') do
          get api_v1_forecast_path, headers: headers, params: valid_params
          forecast = JSON.parse(response.body, symbolize_names: true)

          current_weather = forecast[:data][:attributes][:current_weather]
          daily = forecast[:data][:attributes][:daily_weather][0]
          hourly = forecast[:data][:attributes][:hourly_weather][0]
          expect(forecast).to be_a(Hash)
          expect(forecast).to have_key(:data)
          expect(forecast[:data]).to be_a(Hash)
          expect(forecast[:data]).to have_key(:id)
          expect(forecast[:data][:id]).to eq(nil)
          expect(forecast[:data]).to have_key(:type)
          expect(forecast[:data][:type]).to be_a(String)
          expect(forecast[:data]).to have_key(:attributes)
          expect(forecast[:data][:attributes]).to be_a(Hash)

          expect(current_weather).to be_a(Hash)
          expect(current_weather).to have_key(:temperature)
          expect(current_weather).to have_key(:sunrise)
          expect(current_weather).to have_key(:datetime)
          expect(current_weather).to have_key(:sunset)
          expect(current_weather).to have_key(:feels_like)
          expect(current_weather).to have_key(:humidity)
          expect(current_weather).to have_key(:uvi)
          expect(current_weather).to have_key(:visibility)
          expect(current_weather).to have_key(:conditions)
          expect(current_weather).to have_key(:icon)

          expect(forecast[:data][:attributes]).to have_key(:daily_weather)
          expect(forecast[:data][:attributes][:daily_weather]).to be_a(Array)
          expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
          expect(daily).to have_key(:datetime)
          expect(daily[:datetime]).to be_a(String)
          expect(daily).to have_key(:sunrise)
          expect(daily[:sunrise]).to be_a(String)
          expect(daily).to have_key(:sunset)
          expect(daily[:sunset]).to be_a(String)
          expect(daily).to have_key(:max_temp)
          expect(daily[:max_temp]).to be_a(Float)
          expect(daily).to have_key(:min_temp)
          expect(daily[:min_temp]).to be_a(Float)
          expect(daily).to have_key(:conditions)
          expect(daily[:conditions]).to be_a(String)
          expect(daily).to have_key(:icon)
          expect(daily[:icon]).to be_a(String)

          expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
          expect(forecast[:data][:attributes][:hourly_weather]).to be_a(Array)
          expect(forecast[:data][:attributes][:hourly_weather].count).to eq(48)
          expect(hourly).to have_key(:time)
          expect(hourly[:time]).to be_a(String)
          expect(hourly).to have_key(:temperature)
          expect(hourly[:temperature]).to be_a(Float)
          expect(hourly).to have_key(:conditions)
          expect(hourly[:conditions]).to be_a(String)
          expect(hourly).to have_key(:icon)
          expect(hourly[:icon]).to be_a(String)

          expect(current_weather).to_not have_key(:pressure)
          expect(current_weather).to_not have_key(:dewpoint)
          expect(current_weather).to_not have_key(:wind_speed)
          expect(current_weather).to_not have_key(:wind_deg)

          expect(daily).to_not have_key(:pressure)
          expect(daily).to_not have_key(:dewpoint)
          expect(daily).to_not have_key(:wind_speed)
          expect(daily).to_not have_key(:wind_deg)

          expect(hourly).to_not have_key(:pressure)
          expect(hourly).to_not have_key(:dewpoint)
          expect(hourly).to_not have_key(:wind_speed)
          expect(hourly).to_not have_key(:wind_deg)
        end
      end
    end
    context 'when location is invalid' do
      it 'returns status code 404, error message' do
        VCR.use_cassette('blank_location') do
          get api_v1_forecast_path, headers: headers, params: invalid_params
          expect(response).to have_http_status(400)
          expect(response.body).to match(/Location parameter is required/)
        end
      end
    end
  end
end
