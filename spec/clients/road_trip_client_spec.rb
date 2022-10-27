require 'rails_helper'

RSpec.describe RoadTripClient do
  describe '::get_road_trip/2' do
    it 'returns json response with travel times' do
      VCR.use_cassette('road_trip_1') do
        destination = RoadTripClient.get_road_trip('denver,co', 'pueblo, co')
        expect(destination).to have_key(:route)
        expect(destination[:route]).to have_key(:formattedTime)
        expect(destination[:route][:formattedTime]).to be_a(String)

        expect(destination[:route]).to have_key(:locations)
        expect(destination[:route][:locations]).to be_a(Array)
        expect(destination[:route][:locations][0]).to have_key(:adminArea5)
        expect(destination[:route][:locations][0][:adminArea5]).to be_a(String)
        expect(destination[:route][:locations][1][:adminArea5]).to be_a(String)
      end
    end
  end
end
