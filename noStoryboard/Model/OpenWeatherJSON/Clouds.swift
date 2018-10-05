import ObjectMapper

public class Clouds: Base {
  public var all: Double?
  
  override public func mapping(map: Map) {
    super.mapping(map: map)

    all <- map["all"]
  }
}
