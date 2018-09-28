import ObjectMapper

/*
 Coordinates from the OpenWeatherMap API
 */

public class Coordinates: Base {
  public var longitude: Double?
  public var latitude: Double?

  override public func mapping(map: Map) {
    super.mapping(map: map)
    
    longitude <- map["lon"]
    latitude <- map["lat"]
  }
}
