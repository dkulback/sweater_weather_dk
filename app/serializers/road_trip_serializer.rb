class RoadTripSerializer
  def self.road_trip(trip)
    {
      "data": {
        "id": nil,
        "type": 'roadtrip',
        "attributes": {
          "start_city": trip.start,
          "end_city": trip.end_point,
          "travel_time": trip.travel_time,
          "weather_at_eta": trip.weather_eta
        }
      }
    }
  end
end
