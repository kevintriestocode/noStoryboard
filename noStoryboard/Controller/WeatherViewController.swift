import UIKit
import SnapKit
import Alamofire
import ObjectMapper

class WeatherViewController: UIViewController {
  var cityNameLabel: UILabel!
  var descLabel: UILabel!
  
  var temperatureLabel: UILabel!
  var dayLabel: UILabel!
  
  var highsLabel: UILabel!
  var lowsLabel:UILabel!
  
  var lineView: LineView!
  var timeLabel: UILabel!
  
  var settings: Settings!
  var zipcode: String!
  
  var apiKey: String!
  var apiCall: String!
  
  override func viewDidLoad() {
    cityNameLabel = UILabel()
    descLabel = UILabel()
    temperatureLabel = UILabel()
    dayLabel = UILabel()
    highsLabel = UILabel()
    lowsLabel = UILabel()
    lineView = LineView()
    timeLabel = UILabel()
    
    print("WeatherViewController did load")
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(popSettings))
    
    title = "Weather"
    
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    settings = Settings()
    settings.loadSettings()
    
    zipcode = settings.zipCode

    apiKey = settings.weatherAPIKey
    
    if let apiKey = apiKey {
      apiCall = "https://api.openweathermap.org/data/2.5/weather?zip=" + zipcode + ",us&appid=" + apiKey
    } else {
      apiCall = "https://api.openweathermap.org/data/2.5/weather?zip=11222,us&appid="
    }
    
    networkingAndLabels()
  }
  
  func setupViews() {
    view.backgroundColor = Configuration.Color.backgroundColor
    
    view.addSubview(cityNameLabel)
    view.addSubview(descLabel)
    
    view.addSubview(temperatureLabel)
    view.addSubview(dayLabel)
    
    view.addSubview(highsLabel)
    view.addSubview(lowsLabel)
    
    view.addSubview(lineView)
    view.addSubview(timeLabel)
    
    cityNameLabel.text = "City Name, @@"
    cityNameLabel.textColor = .white
    
    cityNameLabel.font = UIFont.systemFont(ofSize: 24)
    cityNameLabel.numberOfLines = 0
    
    cityNameLabel.lineBreakMode = .byWordWrapping
    cityNameLabel.textAlignment = .center
    
    cityNameLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
      make.centerX.equalTo(view)
    }
    
    descLabel.text = "Skies"
    descLabel.textColor = .white
    
    descLabel.font = UIFont.systemFont(ofSize: 18)
    descLabel.numberOfLines = 0
    
    descLabel.lineBreakMode = .byWordWrapping
    descLabel.textAlignment = .center
    
    descLabel.snp.makeConstraints { make in
      make.top.equalTo(cityNameLabel.snp.bottom).offset(5)
      make.centerX.equalTo(view)
    }
    
    temperatureLabel.text = "0.0 ºF"
    temperatureLabel.textColor = .white
    
    temperatureLabel.font = UIFont.systemFont(ofSize: 48)
    temperatureLabel.numberOfLines = 0
    
    temperatureLabel.lineBreakMode = .byWordWrapping
    temperatureLabel.textAlignment = .center
    
    temperatureLabel.snp.makeConstraints { make in
      make.top.equalTo(descLabel.snp.bottom).offset(10)
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
    lineView.snp.makeConstraints { make in
      make.top.equalTo(dayLabel.snp.bottom).offset(4.5)
      make.width.equalTo(view).inset(5)
      make.centerX.equalTo(view)
    }
    
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

  @objc func popSettings() {
    let settingsVC = SettingsViewController()
    self.navigationController?.pushViewController(settingsVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
    self.navigationController?.navigationBar.tintColor = .white
  }

  @objc func networkingAndLabels() {
    // Alamofire + ObjectMapper
    /// see: public class Response
    Alamofire.request(apiCall).responseJSON { response in print(response) }
    Alamofire.request(apiCall).responseString { response in
      if let jsonString = response.result.value {
        if let responseObject = Response(JSONString: jsonString) {
          guard responseObject.cod != 401 else {
            self.temperatureLabel.text = "401 Error: Invalid API Key"
            return
          }
          // City Name Label
          if let cityName = responseObject.name {
            self.cityNameLabel.text = cityName
          }
          // desc Label
          if let desc = responseObject.weather?[0].main { // Note: "desc" not "description". Also some weird ()'s in JSON...
            self.descLabel.text = desc
            print(desc)
          }
          // Temperature Label
          if let temperature = responseObject.main?.temperature! {
            self.temperatureLabel.text = temperature.kelvinToFarenheit() + " ºF"
          }
          // Time Label
          if let time = responseObject.dt {
            self.timeLabel.text = "Last updated: \(Date(timeIntervalSince1970: time).description(with: Locale.current))"
          }
          // Highs
          if let maximumTemperature = responseObject.main?.maximumTemperature?.kelvinToFarenheit() {
            self.highsLabel.text = maximumTemperature
          }
          // Lows
          if let minimumTemperature = responseObject.main?.minimumTemperature?.kelvinToFarenheit() {
            self.lowsLabel.text = minimumTemperature
          }
        }
      }
    }
  }
}
