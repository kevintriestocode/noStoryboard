import ObjectMapper

public class Wind: Base {
  public var deg: Double?
  public var  speed: String?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    deg <- map["deg"]
    speed <- map["speed"]
  }
}
