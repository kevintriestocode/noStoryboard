import ObjectMapper

public class ResultsObject: Base {
  public var addressComponents: [AddressComponents]?
  public var formattedAddress: String?
  public var geometry: Geometry?
  public var placeID: String?
  public var types: [String]?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    addressComponents <- map["address_components"]
    formattedAddress <- map["formatted_address"]
    geometry <- map["geometry"]
    placeID <- map["place_id"]
    types <- map["types"]
  }
}
