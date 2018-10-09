import ObjectMapper

public class Location: Base {
  public var lat: Double?
  public var lon: Double?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    lat <- map["lat"]
    lon <- map["lon"]
  }
}
