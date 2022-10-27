class BackgroundsClient
  def self.get_url(url, location)
    conn = Faraday.new(url: 'https://api.pexels.com') do |faraday|
      faraday.headers['Authorization'] = ENV['photo_api_key']
      faraday.params[:query] = "#{location},skyline"
      faraday.params[:per_page] = 1
    end

    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_background(location)
    get_url('v1/search', location)
  end
end
