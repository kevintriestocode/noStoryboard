import UIKit

class Settings: NSObject, NSCoding {
  static let sharedSettings = Settings()

  var arbitraryID = "Settings.sharedSettings"
  
  var username: String?
  var weatherAPIKey: String?
  var googleAPIKey: String?
  var zipCode: String?
  var toggleCF: Int?

  override init() {
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    username = aDecoder.decodeObject(forKey: "username") as? String
    weatherAPIKey = aDecoder.decodeObject(forKey: "weatherAPIKey") as? String
    googleAPIKey = aDecoder.decodeObject(forKey: "googleAPIKey") as? String
    zipCode = aDecoder.decodeObject(forKey: "zipCode") as? String
    toggleCF = aDecoder.decodeObject(forKey: "toggleCF") as? Int
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(username, forKey: "username")
    aCoder.encode(weatherAPIKey, forKey: "weatherAPIKey")
    aCoder.encode(googleAPIKey, forKey: "googleAPIKey")
    aCoder.encode(zipCode, forKey: "zipCode")
    aCoder.encode(toggleCF, forKey: "toggleCF")
  }

  func settingsKey() -> String {
    return arbitraryID
  }

  func saveSettings() {
    UserDefaults.standard.set(username, forKey: "username")
    UserDefaults.standard.set(weatherAPIKey, forKey: "weatherAPIKey")
    UserDefaults.standard.set(googleAPIKey, forKey: "googleAPIKey")
    UserDefaults.standard.set(zipCode, forKey: "zipCode")
    UserDefaults.standard.set(toggleCF, forKey: "toggleCF")
  }

  func loadSettings() {
    username = UserDefaults.standard.string(forKey: "username")
    weatherAPIKey = UserDefaults.standard.string(forKey: "weatherAPIKey")
    googleAPIKey = UserDefaults.standard.string(forKey: "googleAPIKey")
    zipCode = UserDefaults.standard.string(forKey: "zipCode")
    toggleCF = UserDefaults.standard.integer(forKey: "toggleCF")
  }

//  func loadSettings() {
//    if let decoded = UserDefaults.standard.object(forKey: settingsKey()) as? Data {
//      if let loadedSettings = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Settings {
//        username = loadedSettings.username
//        weatherAPIKey = loadedSettings.weatherAPIKey
//        zipCode = loadedSettings.zipCode
//      }
//    } else {
//      username = UserDefaults.standard.string(forKey: "username")
//      weatherAPIKey = UserDefaults.standard.string(forKey: "weatherAPIKey")
//      zipCode = UserDefaults.standard.string(forKey: "zipCode")
//    }
//  }
}
