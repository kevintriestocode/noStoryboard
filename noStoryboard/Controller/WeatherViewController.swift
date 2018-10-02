import UIKit
import SnapKit
import Alamofire
import ObjectMapper

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
//    print("your request looks like: <\(apiCall!)>")

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
    
    // Alamofire + ObjectMapper
    /// see: public class Response 
    Alamofire.request(apiCall).responseString { response in
      print(response)
      if let jsonString = response.result.value {
        if let responseObject = Response(JSONString: jsonString) {
          if let temperatureK = responseObject.main?.temperature {
            let temperatureF: Double = 9 / 5 * (temperatureK - 273) + 32
            let degrees = String(format: "%.1f", temperatureF)
            self.weatherLabel.text = "It's currently \(degrees)ºF in Greenpoint"
          }
        }
      }
    }
  }
}
