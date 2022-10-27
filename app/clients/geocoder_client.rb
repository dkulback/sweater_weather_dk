class GeocoderClient
  def self.get_url(url, location)
    conn = Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
      faraday.params[:location] = location
      faraday.params[:key] = ENV['map_api_key']
    end
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_coordinates(location)
    get_url('/geocoding/v1/address', location)
  end
end
