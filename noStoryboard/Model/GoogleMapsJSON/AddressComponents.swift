import ObjectMapper

public class AddressComponents: Base {
  public var longName: String?
  public var shortName: String?
  public var types: [String]?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    longName <- map["long_name"]
    shortName <- map["short_name"]
    types <- map["types"]
  }
}
