import UIKit
import SnapKit
import Alamofire
import ObjectMapper

class WeatherViewController: UIViewController {
  var cityNameLabel: UILabel!
  var descLabel: UILabel!
  
  var temperatureLabel: UILabel!
  var timeLabel: UILabel!
  
  var settings: Settings!
  
  var apiKey: String!
  var currentConditionsAPICall: String!
  
  override func viewDidLoad() {
    cityNameLabel = UILabel()
    descLabel = UILabel()
    temperatureLabel = UILabel()
    timeLabel = UILabel()
    
    print("WeatherViewController did load")
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
    
    settings = Settings()
    settings.loadSettings()
    
    apiKey = settings.weatherAPIKey
    
    if let apiKey = apiKey {
      currentConditionsAPICall = "https://dataservice.accuweather.com/currentconditions/v1/11222?apikey=" + apiKey
    } else {
      currentConditionsAPICall = "https://dataservice.accuweather.com/currentconditions/v1/11222?apikey="
    }

    setupViews()
    networkingAndLabels()
  }
  
  func setupViews() {
    view.backgroundColor = Configuration.Color.backgroundColor

    view.addSubview(cityNameLabel)
    view.addSubview(descLabel)

    view.addSubview(temperatureLabel)
    view.addSubview(timeLabel)

    cityNameLabel.text = "City Name"
    cityNameLabel.textColor = .white
    
    cityNameLabel.font = UIFont.systemFont(ofSize: 24)
    cityNameLabel.numberOfLines = 0
    
    cityNameLabel.lineBreakMode = .byWordWrapping
    cityNameLabel.textAlignment = .center
    
    cityNameLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
      make.centerX.equalTo(view)
    }
    
    descLabel.text = "---"
    descLabel.textColor = .white
    
    descLabel.font = UIFont.systemFont(ofSize: 18)
    descLabel.numberOfLines = 0
    
    descLabel.lineBreakMode = .byWordWrapping
    descLabel.textAlignment = .center
    
    descLabel.snp.makeConstraints { make in
      make.top.equalTo(cityNameLabel.snp.bottom).offset(5)
      make.centerX.equalTo(view)
    }
    
    temperatureLabel.text = "Temperature"
    temperatureLabel.textColor = .white
    
    temperatureLabel.font = UIFont.systemFont(ofSize: 48)
    temperatureLabel.numberOfLines = 0

    temperatureLabel.lineBreakMode = .byWordWrapping
    temperatureLabel.textAlignment = .center
    
    temperatureLabel.snp.makeConstraints { make in
      make.top.equalTo(descLabel.snp.bottom).offset(5)
      make.centerX.equalTo(view)
    }
    
    timeLabel.text = "Last updated: ..."
    timeLabel.textColor = .white
    
    timeLabel.font = UIFont.systemFont(ofSize: 12)
    timeLabel.numberOfLines = 0
    
    timeLabel.lineBreakMode = .byWordWrapping
    timeLabel.textAlignment = .center
    
    timeLabel.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
      make.width.equalTo(view).inset(50)
      make.centerX.equalTo(view)
    }
  }
  
  func networkingAndLabels() {
    // Alamofire + ObjectMapper
    /// see: public class Response
//    Alamofire.request(currentConditionsAPICall).responseJSON { response in print(response) }
    Alamofire.request(currentConditionsAPICall).responseString { response in
      if var jsonString = response.result.value {
        jsonString.removeLast()
        jsonString.removeFirst() //JESUS CHRIST. WTF
        print(jsonString)
        if let responseObject = CurrentConditionsResponse(JSONString: jsonString) {
          // City Name Label
//          if let cityName = responseObject.name {
//            self.cityNameLabel.text = cityName
//          }
          // desc Label
          if let desc = responseObject.weatherText {
            self.descLabel.text = desc
          }
          // Temperature Label
          if let temperature = responseObject.temperature?.imperial?.value {
            self.temperatureLabel.text = "\(temperature) ºF"
          }
          // Time Label
          if let time = responseObject.epochTime {
            self.timeLabel.text = "Last updated: \(Date(timeIntervalSince1970: time).description(with: Locale.current))"
            print("Last updated: \(Date(timeIntervalSince1970: time).description(with: Locale.current))")
          }
        }
      }
    }
  }
}
