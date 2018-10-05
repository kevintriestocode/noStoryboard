import ObjectMapper

public class Temperature: Base {
  public var metric: Format?
  public var imperial: Format?
  
  override public func mapping(map: Map) {
    super.mapping(map: map)

    metric <- map["Metric"]
    imperial <- map["Imperial"]
  }
}
