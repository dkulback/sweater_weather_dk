require 'rails_helper'

RSpec.describe ForecastClient do
  describe '::get_forecast' do
    it 'returns a json response of weather data' do
      VCR.use_cassette('denver_forecast') do
        forecast = ForecastClient.get_forecast('39.738453', '-104.984853')

        expect(forecast).to have_key(:current)
        expect(forecast).to have_key(:daily)
        expect(forecast).to have_key(:hourly)
        expect(forecast).to_not have_key(:minutely)

        current = forecast[:current]
        expect(forecast[:current]).to have_key(:dt)
        expect(forecast[:current]).to have_key(:feels_like)
        expect(forecast[:current]).to have_key(:sunrise)
        expect(forecast[:current]).to have_key(:sunset)
        expect(forecast[:current]).to have_key(:temp)
        expect(forecast[:current]).to have_key(:uvi)
        expect(forecast[:current]).to have_key(:weather)
        expect(forecast[:current][:weather][0]).to have_key(:description)
        expect(forecast[:current][:weather][0]).to have_key(:icon)

        expect(current[:dt]).to be_a(Integer)
        expect(current[:sunrise]).to be_a(Integer)
        expect(current[:sunset]).to be_a(Integer)
        expect(current[:temp]).to be_a(Float)
        expect(current[:feels_like]).to be_a(Float)
        expect(current[:uvi]).to be_a(Integer).or be_a(Float)
        expect(current[:weather][0][:description]).to be_a(String)
        expect(current[:weather][0][:icon]).to be_a(String)

        expect(forecast[:daily].first).to have_key(:dt)
        expect(forecast[:daily].first).to have_key(:sunrise)
        expect(forecast[:daily].first).to have_key(:sunset)
        expect(forecast[:daily].first).to have_key(:temp)
        expect(forecast[:daily].first).to have_key(:feels_like)
        expect(forecast[:daily].first).to have_key(:uvi)
        expect(forecast[:daily].first).to have_key(:weather)
        expect(forecast[:daily].first[:weather][0]).to have_key(:description)
        expect(forecast[:daily].first[:weather][0]).to have_key(:icon)

        daily = forecast[:daily][0]
        expect(daily[:dt]).to be_a(Integer)
        expect(daily[:sunrise]).to be_a(Integer)
        expect(daily[:sunset]).to be_a(Integer)
        expect(daily[:temp][:max]).to be_a(Float)
        expect(daily[:uvi]).to be_a(Float)
        expect(daily[:weather][0][:description]).to be_a(String)
        expect(daily[:weather][0][:icon]).to be_a(String)

        expect(forecast[:hourly].first).to have_key(:dt)
        expect(forecast[:hourly].first).to have_key(:temp)
        expect(forecast[:hourly].first).to have_key(:feels_like)
        expect(forecast[:hourly].first).to have_key(:uvi)
        expect(forecast[:hourly].first).to have_key(:weather)
        expect(forecast[:hourly].first[:weather][0]).to have_key(:description)
        expect(forecast[:hourly].first[:weather][0]).to have_key(:icon)

        hourly = forecast[:hourly][0]
        expect(hourly[:dt]).to be_a(Integer)
        expect(hourly[:temp]).to be_a(Float)
        expect(hourly[:weather][0][:description]).to be_a(String)
        expect(hourly[:weather][0][:icon]).to be_a(String)
      end
    end
  end
end
