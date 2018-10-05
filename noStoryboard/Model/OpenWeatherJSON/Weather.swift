import ObjectMapper

public class Weather: Base {
  public var desc: String?
  public var icon: String?
  public var id: Double?
  public var main: String?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    desc <- map[("description")]
    icon <- map["icon"]
    id <- map["id"]
    main <- map["main"]
  }
}
