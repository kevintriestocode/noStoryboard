// "https://maps.googleapis.com/maps/api/geocode/json?&address=" + zipcode + "&key=" + googleApiKey

import ObjectMapper

public class GoogleResponse: Base {
  public var results: [ResultsObject]?
  public var status: String?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    results <- map["results"]
    status <- map["status"]
  }
}
