import ObjectMapper

public class System: Base {
  public var country: String?
  public var id: Double?
  public var message: Float?
  public var sunrise: Double?
  public var sunset: Double?
  public var type: Double?
  
  override public func mapping(map: Map) {
    super.mapping(map: map)

    country <- map["country"]
    id <- map["id"]
    message <- map["message"]
    sunrise <- map["sunrise"]
    sunset <- map["sunset"]
    type <- map["type"]
  }
}
