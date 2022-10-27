class ForecastServicer
  def self.forecast(lat, lng)
    Forecast.new(ForecastClient.get_forecast(lat, lng))
  end
end
