class RoadTripServicer
  def self.road_trip(origin, destination)
    RoadTrip.new(RoadTripClient.get_road_trip(origin, destination)[:route])
  end
end
