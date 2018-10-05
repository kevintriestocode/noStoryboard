import ObjectMapper

public class PostalCodeSearchResponse: Base {
  public var city: String?
  public var stateID: String?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    city <- map["LocalizedName"]
    stateID <- map["AdministrativeArea.ID"]
  }
}
