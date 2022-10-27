require 'rails_helper'

RSpec.describe RoadTrip do
  let(:roadtrip) do
    RoadTrip.new({ formattedTime: '01:45:23', time: 6892,
                   routeError: { errorCode: -400 },
                   locations: [
                     {
                       adminArea5: 'Denver',
                       adminArea3: 'CO'
                     },
                     adminArea5: 'Pueblo',
                     adminArea3: 'CO'
                   ] })
  end
  describe 'initialize' do
    it 'exists' do
      actual = roadtrip
      expected = RoadTrip

      expect(actual).to be_a(expected)
    end
  end
  describe '#attributes' do
    it 'has a travel time' do
      actual = roadtrip.travel_time
      expected = '01:45:23'
      expect(actual).to eq(expected)
    end
    it 'has a real time' do
      actual = roadtrip.real_time
      expected = 6892
      expect(actual).to eq(expected)
    end
    it 'has a start' do
      actual = roadtrip.start
      expected = 'Denver,CO'
      expect(actual).to eq(expected)
    end
    it 'has a end' do
      actual = roadtrip.end_point
      expected = 'Pueblo,CO'
      expect(actual).to eq(expected)
    end
  end
  describe 'format_time' do
    it 'returns real_time in a Time Class' do
      actual = roadtrip.format_time_hour
      expected = 2
      expect(actual).to eq(expected)
    end
  end
  describe 'forecast/1' do
    it 'has a forecast for the destination' do
      VCR.use_cassette('pueblo_co') do
        actual = roadtrip.forecast
        expected = Forecast
        expect(actual).to be_a(expected)
      end
    end
  end
  describe 'weather_eta' do
    it 'returns the temperature and conditions at destination from eta' do
      VCR.use_cassette('pueblo_co') do
        actual = roadtrip.weather_eta
        expected = Hash
        expect(actual).to be_a(expected)
        expect(actual).to have_key(:temperature)
        expect(actual).to have_key(:conditions)
        expect(actual[:conditions]).to be_a(String)
        expect(actual[:temperature]).to be_a(Float)
      end
    end
  end
end
