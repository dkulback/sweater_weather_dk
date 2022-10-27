class ForecastServicer
  def self.forecast(lat, lng)
    ForecastClient.get_forecast(lat, lng)
  end
end
