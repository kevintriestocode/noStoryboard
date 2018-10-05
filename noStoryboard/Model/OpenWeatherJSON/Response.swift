import ObjectMapper

public class Response: Base {
  public var base: String?
  public var clouds: Clouds?
  public var cod: Double?
  public var coord: Coordinates?
  public var dt: Double?
  public var id: Double?
  public var main: Main?
  public var name: String?
  public var sys: System?
  public var visibility: Float?
  public var weather: Weather?
  public var wind: Wind?
  public var message: String?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    base <- map["base"]
    clouds <- map["clouds"]
    cod <- map["cod"]
    coord <- map["coord"]
    dt <- map["dt"]
    id <- map["id"]
    main <- map["main"]
    name <- map["name"]
    sys <- map["sys"]
    visibility <- map["visibility"]
    weather <- map["weather"]
    wind <- map["wind"]
    message <- map["message"]
  }
}
