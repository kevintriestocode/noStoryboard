import UIKit

class Settings: NSObject, NSCoding {
  static let sharedSettings = Settings()

  var arbitraryID = "Settings.sharedSettings"
  
  var username: String?
  var weatherAPIKey: String?
  var zipCode: String?

  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    username = aDecoder.decodeObject(forKey: "username") as? String
    weatherAPIKey = aDecoder.decodeObject(forKey: "weatherAPIKey") as? String
    zipCode = aDecoder.decodeObject(forKey: "zipCode") as? String
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(username, forKey: "username")
    aCoder.encode(weatherAPIKey, forKey: "weatherAPIKey")
    aCoder.encode(zipCode, forKey: "zipCode")
  }

  func settingsKey() -> String {
    return arbitraryID
  }

//  func saveSettings() {
//    UserDefaults.standard.set(username, forKey: "username")
//    UserDefaults.standard.set(weatherAPIKey, forKey: "weatherAPIKey")
//    UserDefaults.standard.set(zipCode, forKey: "zipCode")
//  }

  func saveSettings() {
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: self)
    UserDefaults.standard.set(encodedData, forKey: settingsKey())
    UserDefaults.standard.synchronize()
  }

//  func loadSettings() {
//    username = UserDefaults.standard.string(forKey: "username")
//    weatherAPIKey = UserDefaults.standard.string(forKey: "weatherAPIKey")
//    zipCode = UserDefaults.standard.string(forKey: "zipCode")
//  }

  func loadSettings() {
    if let decoded = UserDefaults.standard.object(forKey: settingsKey()) as? Data {
      if let loadedSettings = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Settings {
        // FIXME: - Fix me!
      }
    } else {
      username = UserDefaults.standard.string(forKey: "username")
      weatherAPIKey = UserDefaults.standard.string(forKey: "weatherAPIKey")
      zipCode = UserDefaults.standard.string(forKey: "zipCode")
    }
  }
}
