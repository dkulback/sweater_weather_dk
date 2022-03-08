require 'rails_helper'

RSpec.describe GeocoderClient do
  describe '::get_road_trip/2' do
    it 'returns json response with directions' do
      VCR.use_cassette('coordinates_of_pueblo_colorado') do
        coordinates = GeocoderClient.get_coordinates('pueblo, co')
        expect(coordinates[:results][0][:locations][0]).to have_key(:latLng)
        expect(coordinates[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(coordinates[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(coordinates[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
        expect(coordinates[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
      end
    end
  end
end
