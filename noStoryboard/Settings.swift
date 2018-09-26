import UIKit

class Settings: NSObject, NSCoding {
  
  var username: String?
  var weatherAPIKey: String?
  
  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    username = aDecoder.decodeObject(forKey: "username") as? String
    weatherAPIKey = aDecoder.decodeObject(forKey: "weatherAPIKey") as? String
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(username, forKey: "username")
    aCoder.encode(weatherAPIKey, forKey: "weatherAPIKey")
  }
  
  func saveSettings() {
    UserDefaults.standard.set(username, forKey: "username")
    UserDefaults.standard.set(weatherAPIKey, forKey: "weatherAPIKey")
  }
  
  func loadSettings() {
    username = UserDefaults.standard.string(forKey: "username")
    weatherAPIKey = UserDefaults.standard.string(forKey: "weatherAPIKey")
  }
}
