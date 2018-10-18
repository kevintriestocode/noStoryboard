import UIKit
import SnapKit

class TemperatureTimeBlock: UIView {
  var temperatureLabel: UILabel!
  var timeLabel: UILabel!

  convenience override init(frame: CGRect) {
    self.init()

    temperatureLabel = UILabel()
    timeLabel = UILabel()
  }
}

class HourlyWeatherScrollView: UIScrollView {
  var currentTime: Double? // Seconds since UNIX Epoch
  var hour: Double = 3600

  convenience override init(frame: CGRect) {
    self.init(frame: .zero)
  }
}
