class RoadTripClient
  def self.get_url(url, from = nil, to = nil)
    conn = Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
      faraday.params[:key] = ENV['map_api_key']
      faraday.params[:from] = from unless from.nil?
      faraday.params[:to] = to unless to.nil?
    end
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_road_trip(from, to)
    get_url('/directions/v2/route', from, to)
  end
end
