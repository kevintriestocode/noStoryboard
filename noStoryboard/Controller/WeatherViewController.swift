import UIKit
import SnapKit
import Alamofire
import ObjectMapper

class WeatherViewController: UIViewController {
  var cityNameLabel: UILabel!
  var weatherTextLabel: UILabel!
  
  var temperatureLabel: UILabel!
  var dayLabel: UILabel!
  
  var highsLabel: UILabel!
  var lowsLabel: UILabel!
  
  var timeLabel: UILabel!
  
  var settings: Settings!
  
  var apiKey: String!
  
  var currentConditionsAPICall: String!
  var postalCodeSearchAPICall: String!
  var forecast12APICall: String!
  var postalCode = "90210"
  
  
  override func viewDidLoad() {
    cityNameLabel = UILabel()
    weatherTextLabel = UILabel()
    
    temperatureLabel = UILabel()
    dayLabel = UILabel()
    
    highsLabel = UILabel()
    lowsLabel = UILabel()
    
    timeLabel = UILabel()
    
    print("WeatherViewController did load")
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
    
    settings = Settings()
    settings.loadSettings()
    
    apiKey = settings.weatherAPIKey
    
    if let apiKey = apiKey {
      currentConditionsAPICall = "https://dataservice.accuweather.com/currentconditions/v1/\(postalCode)?apikey=" + apiKey
      postalCodeSearchAPICall = "https://dataservice.accuweather.com/locations/v1/postalcodes/US/search?apikey=" + apiKey + "&q=\(postalCode)"
      forecast12APICall = "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(postalCode)?apikey=" + apiKey
    } else {
      currentConditionsAPICall = "https://dataservice.accuweather.com/currentconditions/v1/11222?apikey="
    }

    setupViews()
    networkingAndLabels()
  }
  
  func setupViews() {
    view.backgroundColor = Configuration.Color.backgroundColor

    view.addSubview(cityNameLabel)
    view.addSubview(weatherTextLabel)

    view.addSubview(temperatureLabel)
    view.addSubview(dayLabel)
    
    view.addSubview(highsLabel)
    view.addSubview(lowsLabel)
    
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
    
    weatherTextLabel.text = "---"
    weatherTextLabel.textColor = .white
    
    weatherTextLabel.font = UIFont.systemFont(ofSize: 18)
    weatherTextLabel.numberOfLines = 0
    
    weatherTextLabel.lineBreakMode = .byWordWrapping
    weatherTextLabel.textAlignment = .center
    
    weatherTextLabel.snp.makeConstraints { make in
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
      make.top.equalTo(weatherTextLabel.snp.bottom).offset(10)
      make.centerX.equalTo(view)
    }
    
    /// day - highs - lows
    
    dayLabel.text = "Today"
    dayLabel.textColor = .white
    
    dayLabel.font = UIFont.boldSystemFont(ofSize: 16)
    dayLabel.numberOfLines = 0
    
    dayLabel.lineBreakMode = .byWordWrapping
    dayLabel.textAlignment = .left
    
    dayLabel.snp.makeConstraints { make in
      make.top.equalTo(temperatureLabel.snp.bottom).offset(15)
      make.left.equalTo(view).offset(10)
      
    }
    
    highsLabel.text = "Highs"
    highsLabel.textColor = .white
    
    highsLabel.font = UIFont.boldSystemFont(ofSize: 16)
    highsLabel.numberOfLines = 0
    
    highsLabel.lineBreakMode = .byWordWrapping
    highsLabel.textAlignment = .center
    
    highsLabel.snp.makeConstraints { make in
      make.centerY.height.equalTo(dayLabel)
//      make.left.equalTo(dayLabel)
      make.right.equalTo(lowsLabel.snp.left).offset(-10)
      make.width.equalTo(self.highsLabel.intrinsicContentSize)
    }
    
    lowsLabel.text = "Lows"
    lowsLabel.textColor = .lightGray
    
    lowsLabel.font = UIFont.boldSystemFont(ofSize: 16)
    lowsLabel.numberOfLines = 0
    
    lowsLabel.lineBreakMode = .byWordWrapping
    lowsLabel.textAlignment = .center
    
    lowsLabel.snp.makeConstraints { make in
      make.centerY.height.equalTo(dayLabel)
      make.right.equalTo(view).offset(-10)
      make.width.equalTo(self.lowsLabel.intrinsicContentSize)
    }
    
    ///
    
    timeLabel.text = "Last updated: ..."
    timeLabel.textColor = .white
    
    timeLabel.font = UIFont.systemFont(ofSize: 12)
    timeLabel.numberOfLines = 0
    
    timeLabel.lineBreakMode = .byWordWrapping
    timeLabel.textAlignment = .center
    
    timeLabel.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
      make.width.equalTo(view).inset(50)
      make.centerX.equalTo(view)
    }
  }
  
  func networkingAndLabels() {
    // Alamofire + ObjectMapper
    
//    Alamofire.request(currentConditionsAPICall).responseJSON { response in
    Alamofire.request(currentConditionsAPICall).responseString { response in
      if var jsonString = response.result.value {
        jsonString.removeLast()
        jsonString.removeFirst() //JESUS CHRIST. WTF
        print(jsonString)
        if let responseObject = CurrentConditionsResponse(JSONString: jsonString) {
          print(responseObject)
          // Weather Text Label
          if let weatherText = responseObject.weatherText {
            self.weatherTextLabel.text = weatherText
          }
          // Temperature Label
          if let temperature = responseObject.temperature?.imperial?.value {
            self.temperatureLabel.text = "\(temperature) ºF"
          }
          // Time Label
          if let time = responseObject.epochTime {
            self.timeLabel.text = "Last updated: \(Date(timeIntervalSince1970: time).description(with: Locale.current))"
          }
        }
      }
    }
    
    //  MARK: -- TODO
//    let apiResponse = Mapper<CurrentConditionsResponse>().mapArray(JSONObject: response.result.value)
    Alamofire.request(postalCodeSearchAPICall).responseJSON { response in
      let apiResponse = Mapper<CurrentConditionsResponse>().mapArray(JSONObject: response.result.value)
    }
    
    Alamofire.request(postalCodeSearchAPICall).responseString { response in
      if var jsonString = response.result.value {
        jsonString.removeLast()
        jsonString.removeFirst() //JESUS CHRIST. WTF
        if let responseObject = PostalCodeSearchResponse(JSONString: jsonString) {
          if let cityName = responseObject.city {
            self.cityNameLabel.text = "\(cityName)"
          }
          if let stateID = responseObject.stateID {
            self.cityNameLabel.text!.append(", \(stateID)")
          }
        }
      }
    }
  }
}
