import UIKit
import SnapKit
import Alamofire

class WeatherViewController: CoreTextViewController {
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
    
    weatherLabel.backgroundColor = UIColor.white
    weatherLabel.snp.makeConstraints { make in
      make.top.left.equalTo(view)
      make.width.height.equalTo(view)
    }
    
    // Alamofire magic...
    Alamofire.request(apiCall).responseJSON { response in
//      print(response)
      
      if let weatherJSON = response.result.value {
        let weatherObject: Dictionary = weatherJSON as! Dictionary<String, Any>
        
        let weatherMain: Dictionary = weatherObject["main"] as! Dictionary<String, Any>
        let weatherTempInKelvin: NSNumber = weatherMain["temp"] as! NSNumber
        
        let weatherTempInFarenheit: Float = 9 / 5 * (weatherTempInKelvin.floatValue - 273) + 32
        self.weatherLabel.text = "\(weatherTempInFarenheit)º f"
      }
    }
  }
}
