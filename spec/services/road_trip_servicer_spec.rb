require 'rails_helper'

RSpec.describe RoadTripServicer do
  describe '::road_trip/2' do
    it 'returns a RoadTrip object' do
      VCR.use_cassette('pueblo_co_road_trip') do
        road_trip = RoadTripServicer.road_trip('denver,co', 'pueblo, co')

        expect(road_trip).to be_a(RoadTrip)
      end
    end
  end
end
