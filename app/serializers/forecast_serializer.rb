class ForecastSerializer
  def self.weather(forecast)
    { "data": {
      "id": nil,
      "type": 'forecast',
      "attributes": {
        "current_weather": {
          "datetime": Time.at(forecast[:current][:dt]),
          "temperature": forecast[:current][:temp],
          "sunrise": Time.at(forecast[:current][:sunrise]),
          "sunset": Time.at(forecast[:current][:sunset]),
          "feels_like": forecast[:current][:feels_like],
          "humidity": forecast[:current][:humidity],
          "uvi": forecast[:current][:uvi],
          "visibility": forecast[:current][:visibility],
          "conditions": forecast[:current][:weather][0][:description],
          "icon": forecast[:current][:weather][0][:icon]
        },
        "daily_weather": forecast[:daily][0..4].map do |data|
          {
            "datetime": Time.at(data[:dt]),
            "sunrise": Time.at(data[:sunrise]),
            "sunset": Time.at(data[:sunset]),
            "max_temp": data[:temp][:max],
            "min_temp": data[:temp][:min],
            "conditions": data[:weather][0][:description],
            "icon": data[:weather][0][:icon]
          }
        end,
        "hourly_weather": forecast[:hourly][0..7].map do |data|
          {
            "time": Time.at(data[:dt]).to_datetime.strftime('%H-%M-%S'),
            "temperature": data[:temp],
            "conditions": data[:weather][0][:description],
            "icon": data[:weather][0][:icon]
          }
        end
      }

    } }
  end
end
