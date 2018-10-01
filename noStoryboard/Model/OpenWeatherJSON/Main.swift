import ObjectMapper

/*
 Main from the OpenWeatherMap API
 */

public class Main: Base {
  public var temperature: Double?
  public var pressure: Double?
  public var humidity: Double?
  public var minimumTemperature: Double?
  public var maximumTemperature: Double?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    temperature <- map["temp"]
    pressure <- map["pressure"]
    humidity <- map["humidity"]
    minimumTemperature <- map["temp_min"]
    maximumTemperature <- map["temp_max"]
  }
}
