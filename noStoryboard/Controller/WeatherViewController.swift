import UIKit
import SnapKit
import Alamofire
import ObjectMapper
import MapKit

class WeatherViewController: UIViewController, MKMapViewDelegate {
  var weatherView: WeatherView!
  var map: MKMapView!
  
  var placemark: MKPointAnnotation?
  
  var settings: Settings!
  var zipcode: String!
  
  var lat: Double?
  var lng: Double?
  
  var weatherAPIKey: String!
  var weatherAPICall: String!
  
  var googleAPIKey: String!
  var googleAPICall: String!
  
  override func viewDidLoad() {
    weatherView = WeatherView()
    map = MKMapView(frame: .zero)
    self.map.delegate = self
    map.isZoomEnabled = true
    map.isRotateEnabled = false
    placemark = MKPointAnnotation()
    
    print("WeatherViewController did load")
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(pushSettings))
    
    title = "Weather"
    
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    settings = Settings()
    settings.loadSettings()
    
    zipcode = settings.zipCode
    weatherAPIKey = settings.weatherAPIKey
    googleAPIKey = settings.googleAPIKey
    
    if let apiKey = weatherAPIKey {
      weatherAPICall = "https://api.openweathermap.org/data/2.5/weather?zip=" + zipcode + ",us&appid=" + apiKey
    } else {
      weatherAPICall = "https://api.openweathermap.org/data/2.5/weather?zip=11222,us&appid="
    }
    
    if let googleAPIKey = googleAPIKey {
      googleAPICall = "https://maps.googleapis.com/maps/api/geocode/json?&address=" + zipcode + "&key=" + googleAPIKey
    }
    getLatLngFromGoogle(URL: googleAPICall)
    networkingAndLabels(URL: weatherAPICall)
    
  }
  
  func setupViews() {
    view.addSubview(weatherView)
    weatherView.snp.makeConstraints { make in
      make.edges.equalTo(view)
    }
    weatherView.addSubview(map)
    map.layer.cornerRadius = Configuration.Label.cornerRadius
    map.snp.makeConstraints { make in
      make.left.right.equalTo(view).inset(5)
      make.top.equalTo(weatherView.lineView.snp.bottom).offset(5)
      make.centerX.equalTo(view)
      make.height.equalTo(view.snp.width)
    }
  }

  @objc func pushSettings() {
    let settingsVC = SettingsViewController()
    self.navigationController?.pushViewController(settingsVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
    self.navigationController?.navigationBar.tintColor = .white
  }
  
  func getLatLngFromGoogle(URL: String) {
    Alamofire.request(URL).responseString { response in
      if let jsonString = response.result.value {
        print(jsonString)
        if let responseObject = GoogleResponse(JSONString: jsonString) {
          if let lat = responseObject.results?[0].geometry?.location?.lat {
            print("Lat will = \(lat)")
            self.lat = lat
          }
          if let lng = responseObject.results?[0].geometry?.location?.lng {
            print("Lng will = \(lng)")
            self.lng = lng
          }
        }
      }
    }
  }
  
  func networkingAndLabels(URL: String) {
//    Alamofire.request(URL).responseJSON { response in print(response) }
    Alamofire.request(URL).responseString { response in
      if let jsonString = response.result.value {
        print(jsonString)
        if let responseObject = WeatherResponse(JSONString: jsonString) {
          guard responseObject.cod != 401 else {
            self.weatherView.temperatureLabel.text = "401 Error: Invalid API Key"
            return
          }
          // City Name Label
          if let cityName = responseObject.name {
            self.weatherView.cityNameLabel.text = cityName
          }
          // desc Label
          if let desc = responseObject.weather?[0].main { // Note: "desc" not "description". Also some weird ()'s in JSON...
            self.weatherView.descLabel.text = desc
            print(desc)
          }
          // Temperature Label
          if let temperature = responseObject.main?.temperature! {
            self.weatherView.temperatureLabel.text = temperature.kelvinToFarenheit() + " ºF"
          }
          // Time Label
          if let time = responseObject.dt {
            self.weatherView.timeLabel.text = "Last updated: \(Date(timeIntervalSince1970: time).description(with: Locale.current))"
          }
          // Highs
          if let maximumTemperature = responseObject.main?.maximumTemperature?.kelvinToFarenheit() {
            self.weatherView.highsLabel.text = maximumTemperature
          }
          // Lows
          if let minimumTemperature = responseObject.main?.minimumTemperature?.kelvinToFarenheit() {
            self.weatherView.lowsLabel.text = minimumTemperature
          }
          // Coordinates
//          if let lat = self.lat, let lng = self.lng {
          let center = CLLocationCoordinate2D(latitude: self.lat!, longitude: self.lng!)
          let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
          
          self.placemark?.coordinate = center
          self.map.addAnnotation(self.placemark!)
          
          self.map.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
        }
      }
    }
  }
}
