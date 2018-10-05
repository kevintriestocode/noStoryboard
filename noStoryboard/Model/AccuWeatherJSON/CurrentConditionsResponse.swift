import ObjectMapper

public class CurrentConditionsResponse: Base {
  public var localObservationDateTime: String?
  public var epochTime: Double?
  public var weatherText: String?
  public var isDayTime: Bool?
  public var temperature: Temperature?

  override public func mapping(map: Map) {
    super.mapping(map: map)

    localObservationDateTime <- map["LocalObservationDateTime"]
    epochTime <- map["EpochTime"]
    weatherText <- map["WeatherText"]
    isDayTime <- map["IsDayTime"]
    temperature <- map["Temperature"]
}
