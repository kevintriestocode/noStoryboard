import ObjectMapper

/**
 This class exists solely so we don't need to write init and mapping with every new model
 */
public class Base: NSObject, Mappable {
  public required init?(map: Map) { }
  public func mapping(map: Map) { }
}
