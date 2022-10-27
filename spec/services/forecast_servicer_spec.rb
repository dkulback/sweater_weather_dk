require 'rails_helper'

RSpec.describe ForecastServicer do
  describe '::forecast/2' do
    it 'returns a forecast objext' do
      VCR.use_cassette('denver_forecast') do
        actual = ForecastServicer.forecast('39.738453', '-104.984853')
        expected = Forecast
        expect(actual).to be_a(expected)
      end
    end
  end
end
