class Forecast
  include ActiveModel::Serializers::JSON

  attr_reader :current, :hourly, :daily

  def initialize(data)
    @current = {
      datetime: Time.at(data[:current][:dt]),
      sunrise: Time.at(data[:current][:sunrise]),
      sunset: Time.at(data[:current][:sunset]),
      temperature: data[:current][:temp],
      feels_like: data[:current][:feels_like],
      humidity: data[:current][:humidity],
      uvi: data[:current][:uvi],
      visibility: data[:current][:visibility],
      conditions: data[:current][:weather][0][:description],
      icon: data[:current][:weather][0][:icon]
    }
    @hourly = data[:hourly][0..7].map do |hour|
      {
        time: Time.at(hour[:dt]).to_datetime.strftime('%H-%M-%S'),
        temperature: hour[:temp],
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon]
      }
    end

    @daily = data[:daily][0..4].map do |day|
      {
        datetime: Time.at(day[:dt]),
        sunrise: Time.at(day[:sunrise]),
        sunset: Time.at(day[:sunset]),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon]
      }
    end
  end
end
