import UIKit
import SnapKit
import Alamofire
import ObjectMapper
import MapKit
import Lottie

class WeatherViewController: UIViewController, MKMapViewDelegate {
  var settings: Settings!
  var weatherView: WeatherView!
  
  var map: MKMapView!
  var zipcodePoint: MKPointAnnotation?

  var refresh = LOTAnimationView(name: "refresh", bundle: Bundle.main)

  // From OpenWeatherMap API
  var currentTempK: Double!
  var maximumTempK: Double!
  var minimumTempK: Double!

  // From Google API
  var lat: Double?
  var lng: Double?
  var cityName: String?
  var stateName: String?

  var googleAPICall: GoogleAPICall!

  override func viewDidLoad() {
    settings = Settings.sharedSettings
    settings.loadSettings()

    weatherView = WeatherView()
    weatherView.toggleCF.selectedSegmentIndex = settings.toggleCF ?? 0
    weatherView.toggleCF.addTarget(self, action: #selector(toggleCF), for: .valueChanged)

    map = MKMapView(frame: .zero)
    map.delegate = self

    map.isZoomEnabled = true
    map.isRotateEnabled = false
    map.showsUserLocation = true

    zipcodePoint = MKPointAnnotation()

    refresh.isUserInteractionEnabled = true
    let tapRefresh = UITapGestureRecognizer(target: self, action: #selector(refreshData))
    refresh.addGestureRecognizer(tapRefresh)

    print("WeatherViewController did load")
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(pushSettings))

    title = "Weather"
    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
  }

  func setupViews() {
    view.addSubview(weatherView)
    view.addSubview(refresh)
    
    weatherView.addSubview(map)
    weatherView.snp.makeConstraints { make in
      make.edges.equalTo(view)
    }

    map.layer.cornerRadius = Configuration.Label.cornerRadius
    map.snp.makeConstraints { make in
      make.left.right.equalTo(view).inset(5)
      make.top.equalTo(weatherView.hourlyWeather.snp.bottom).offset(5)
      make.centerX.equalTo(view)
      make.height.equalTo(self.map.snp.width)
    }

    refresh.snp.makeConstraints { make in
      make.left.equalTo(view).offset(-100)
      make.top.equalTo(view).offset(10)
    }
  }

  @objc func pushSettings() {
    let settingsVC = SettingsViewController()
    self.navigationController?.pushViewController(settingsVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
    self.navigationController?.navigationBar.tintColor = .white
  }

  func getLatLngCityFromGoogle(URL: String) {
    Alamofire
      .request(URL)
      .responseString { response in
      if let jsonString = response.result.value {
        print(jsonString)
        if let responseObject = GoogleResponse(JSONString: jsonString) {
          guard responseObject.status == "OK" else {
            self.weatherView.cityNameLabel.text = "Google Error"
            self.weatherView.descLabel.text = "Invalid Request"
            return
          }

          if let lat = responseObject.results?[0].geometry?.location?.lat {
            print("Lat will = \(lat)")
            self.lat = lat
//            openWeatherAPICall.baseParameters["lat"] = lat
          }

          if let lng = responseObject.results?[0].geometry?.location?.lng {
            print("Lng will = \(lng)")
            self.lng = lng
//            openWeatherAPICall.baseParameters["lon"] = lng
          }

          if let cityName = responseObject.results?[0].addressComponents?[1].shortName {
            self.cityName = cityName
          }

          if let stateName = responseObject.results?[0].addressComponents?[4].shortName {
            self.stateName = stateName
          }

          if let center = CLLocationCoordinate2D(latitude: self.lat!, longitude: self.lng!) as? CLLocationCoordinate2D {
            self.zipcodePoint?.coordinate = center
            self.zipcodePoint?.title = self.googleAPICall.settings.zipCode

            self.map.addAnnotation(self.zipcodePoint!)
            if let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) as? MKCoordinateSpan {
              self.map.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
            }
          }

          let openWeatherAPICall = OpenWeatherAPICall()
          openWeatherAPICall.baseParameters["lat"] = self.lat
          openWeatherAPICall.baseParameters["lon"] = self.lng

          self.getWeatherFrom(URL: openWeatherAPICall.current().URLString()!)
        }
      }
    }
  }

  func getWeatherFrom(URL: String) {
    Alamofire.request(URL)
      .responseString { response in
      if let jsonString = response.result.value {
        print(jsonString)
        if let responseObject = WeatherResponse(JSONString: jsonString) {
          guard responseObject.cod != 401 else {
            self.weatherView.cityNameLabel.text = "OpenWeather Error"
            self.weatherView.descLabel.text = "Invalid Request"
            return
          }

          // descLabel
          if let desc = responseObject.weather?[0].main { // Note: "desc" not "description". Also some weird ()'s in JSON...
            self.weatherView.descLabel.text = desc
            print(desc)
          }

          // currentTempF -> temperatureLabel
          if let temperature = responseObject.main?.temperature! {
            self.currentTempK = temperature
          }

          // Time Label
          if let time = responseObject.dt {
            self.weatherView.timeLabel.text = "Last updated: \(Date(timeIntervalSince1970: time).description(with: Locale.current))"
          }

          // maximumTempK -> highsLabel
          if let maximumTemperature = responseObject.main?.maximumTemperature {
            self.maximumTempK = maximumTemperature
          }

          // minimumTempK - lowsLabel
          if let minimumTemperature = responseObject.main?.minimumTemperature {
            self.minimumTempK = minimumTemperature
          }

          self.updateWeatherView()
        }
      }
    }
  }

  func getForecastFrom(URL: String) {
    Alamofire.request(URL).responseString { response in
      print(response.result.value!)
    }
  }

  func updateWeatherView() {
    self.weatherView.cityNameLabel.text = "\(self.cityName ?? "" ), \(self.stateName ?? "")"
    toggleCF()
  }

  @objc func toggleCF() {
    guard self.currentTempK != nil else { return }
    switch weatherView.toggleCF.selectedSegmentIndex {
    case 0:
      self.weatherView.temperatureLabel.text = self.currentTempK.kelvinToCelsius().asString() + " ºC"
      self.weatherView.highsLabel.text = self.maximumTempK.kelvinToCelsius().asString()
      self.weatherView.lowsLabel.text = self.minimumTempK.kelvinToCelsius().asString()
      settings.toggleCF = 0
      UserDefaults.standard.set(settings.toggleCF, forKey: "toggleCF")
      
    case 1:
      
      self.weatherView.temperatureLabel.text = self.currentTempK.kelvinToFarenheit().asString() + " ºF"
      self.weatherView.highsLabel.text = self.maximumTempK.kelvinToFarenheit().asString()
      self.weatherView.lowsLabel.text = self.minimumTempK.kelvinToFarenheit().asString()
      settings.toggleCF = 1
      UserDefaults.standard.set(settings.toggleCF, forKey: "toggleCF")
      
    default:
      return
    }
  }

  @objc func refreshData() {
    self.refresh.play(fromProgress: 0, toProgress: 1) { block in
      self.googleAPICall = GoogleAPICall()
      self.getLatLngCityFromGoogle(URL: self.googleAPICall.URLString()!)
    }

  }
}
