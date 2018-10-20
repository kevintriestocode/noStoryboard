import UIKit
import SnapKit
import Alamofire
import ObjectMapper
import MapKit

class WeatherViewController: UIViewController, MKMapViewDelegate {
  var weatherView: WeatherView!
  var map: MKMapView!

  var zipcodePoint: MKPointAnnotation?

  var currentTempK: Double!
  var maximumTempK: Double!
  var minimumTempK: Double!

  var lat: Double?
  var lng: Double?

  var googleAPICall: GoogleAPICall!

  override func viewDidLoad() {
    weatherView = WeatherView()

    map = MKMapView(frame: .zero)
    map.delegate = self

    map.isZoomEnabled = true
    map.isRotateEnabled = false

    map.showsUserLocation = true

    zipcodePoint = MKPointAnnotation()

    print("WeatherViewController did load")
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(pushSettings))

    title = "Weather"

    setupViews()
  }

  override func viewWillAppear(_ animated: Bool) {
    googleAPICall = GoogleAPICall()
    getLatLngCityFromGoogle(URL: googleAPICall.URLString()!)
  }

  func setupViews() {
    view.addSubview(weatherView)
    
    weatherView.addSubview(map)
    weatherView.snp.makeConstraints { make in
      make.edges.equalTo(view)
    }

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
            self.weatherView.cityNameLabel.text = cityName
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
          self.getWeatherFrom(URL: openWeatherAPICall.URLString()!)
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

          // currentTempK -> temperatureLabel
          if let temperature = responseObject.main?.temperature! {
            self.currentTempK = temperature
            self.weatherView.temperatureLabel.text = self.currentTempK.kelvinToFarenheit() + "ºF"
          }

          // Time Label
          if let time = responseObject.dt {
            self.weatherView.timeLabel.text = "Last updated: \(Date(timeIntervalSince1970: time).description(with: Locale.current))"
          }

          // maximumTempK -> highsLabel
          if let maximumTemperature = responseObject.main?.maximumTemperature {
            self.maximumTempK = maximumTemperature
            self.weatherView.highsLabel.text = self.maximumTempK.kelvinToFarenheit()
          }

          // minimumTempK - lowsLabel
          if let minimumTemperature = responseObject.main?.minimumTemperature {
            self.minimumTempK = minimumTemperature
            self.weatherView.lowsLabel.text = self.minimumTempK.kelvinToFarenheit()
          }
        }
      }
    }
  }
}
