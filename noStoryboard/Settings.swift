import UIKit

class Settings: NSObject, NSCoding {
  
  var username: String?
  
  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    username = aDecoder.decodeObject(forKey: "username") as? String
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(username, forKey: "username")
  }
  
  func saveSettings() {
    UserDefaults.standard.set(username, forKey: "username")
  }
  
  func loadSettings() {
    username = UserDefaults.standard.string(forKey: "username")
  }
}
