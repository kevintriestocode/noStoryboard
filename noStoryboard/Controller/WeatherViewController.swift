import UIKit
import SnapKit
import Alamofire

class WeatherViewController: UIViewController {
  var weatherLabel: UILabel!
  var settings: Settings!
  
  var apiKey: String!
  var apiCall: String!
  
  override func viewDidLoad() {
    weatherLabel = UILabel()
    print("WeatherViewController did load")
    
    settings = Settings()
    settings.loadSettings()
    
    apiKey = settings.weatherAPIKey
    
    apiCall = "https://api.openweathermap.org/data/2.5/weather?zip=11222,us&appid=" + apiKey
    print("your request looks like: <\(apiCall!)>")

    view.backgroundColor = UIColor.white
    view.addSubview(weatherLabel)

    weatherLabel.text = "..."
    weatherLabel.font = UIFont.systemFont(ofSize: 24)
    
    weatherLabel.numberOfLines = 0
    weatherLabel.lineBreakMode = .byWordWrapping
    
    weatherLabel.textAlignment = .center
    weatherLabel.backgroundColor = UIColor.white
    
    weatherLabel.snp.makeConstraints { make in
      make.top.left.equalTo(view)
      make.width.height.equalTo(view)
    }
    
    // Alamofire magic...
    Alamofire.request(apiCall).responseJSON { response in
      print(response)
      
      if let weatherJSON = response.result.value {
        let weatherObject: Dictionary = weatherJSON as! Dictionary<String, Any>
        
        guard Int(weatherObject["cod"] as! Int) == 200 else {
          self.weatherLabel.text = weatherObject["message"] as! String
          return
        }
        
        let weatherMain: Dictionary = weatherObject["main"] as! Dictionary<String, Any>
        let weatherTempInKelvin: Float = Float(weatherMain["temp"] as! NSNumber.FloatLiteralType)
        let weatherHumidity: Float = Float(weatherMain["humidity"] as! NSNumber.FloatLiteralType)
        
        let weatherTempInFarenheit: Float = 9 / 5 * (weatherTempInKelvin - 273) + 32
        
        let formattedTemp = String(format: "%.2f", weatherTempInFarenheit)
        self.weatherLabel.text = "It's currently \(formattedTemp)º f in 11222 with a humidity level of \(weatherHumidity)%"
      }
    }
  }
}
