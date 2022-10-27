class ForecastSerializer
  def self.weather(forecast)
    { "data": {
      "id": nil,
      "type": 'forecast',
      "attributes": {
        "current_weather": {
          "datetime": forecast.current[:datetime],
          "temperature": forecast.current[:temperature],
          "sunrise": forecast.current[:sunrise],
          "sunset": forecast.current[:sunset],
          "feels_like": forecast.current[:feels_like],
          "humidity": forecast.current[:humidity],
          "uvi": forecast.current[:uvi],
          "visibility": forecast.current[:visibility],
          "conditions": forecast.current[:conditions],
          "icon": forecast.current[:icon]
        },
        "daily_weather": forecast.daily.map do |day|
          {
            "datetime": day[:datetime],
            "sunrise": day[:sunrise],
            "sunset": day[:sunset],
            "max_temp": day[:max_temp],
            "min_temp": day[:min_temp],
            "conditions": day[:conditions],
            "icon": day[:icon]
          }
        end,
        "hourly_weather": forecast.hourly.map do |hour|
          {
            "time": hour[:time],
            "temperature": hour[:temperature],
            "conditions": hour[:conditions],
            "icon": hour[:icon]
          }
        end
      }

    } }
  end
end
