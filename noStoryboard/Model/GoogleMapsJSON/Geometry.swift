import ObjectMapper

public class Geometry: Base {
  public var bounds: String?
  public var location: Location?
  public var locationType: String?
  public var viewport: String?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    bounds <- map["bounds"]
    location <- map["location"]
    locationType <- map["location_type"]
    viewport <- map["viewport"]
  }
}
