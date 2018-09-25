import UIKit

class Settings: NSObject, NSCoding {
  
  var username: String?
  var weatherAPI: String?
  
  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    username = aDecoder.decodeObject(forKey: "username") as? String
    weatherAPI = aDecoder.decodeObject(forKey: "weatherAPI") as? String
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(username, forKey: "username")
    aCoder.encode(weatherAPI, forKey: "weatherAPI")
  }
  
  func saveSettings() {
    UserDefaults.standard.set(username, forKey: "username")
    UserDefaults.standard.set(weatherAPI, forKey: "weatherAPI")
  }
  
  func loadSettings() {
    username = UserDefaults.standard.string(forKey: "username")
    weatherAPI = UserDefaults.standard.string(forKey: "weatherAPI")
  }
}
