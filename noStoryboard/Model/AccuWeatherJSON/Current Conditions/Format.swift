import ObjectMapper

public class Format: Base {
  public var value: Double?
  public var unit: String?
  public var unitType: Double?
  
  override public func mapping(map: Map) {
    super.mapping(map: map)

    value <- map["Value"]
    unit <- map["Unit"]
    unitType <- map["UnitType"]
  }
}
