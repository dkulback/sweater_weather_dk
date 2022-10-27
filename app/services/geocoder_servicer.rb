class GeocoderServicer
  def self.convert_location(location)
    coordinates = GeocoderClient.get_coordinates(location)
    coordinates[:results].first[:locations].first[:latLng]
  end
end
