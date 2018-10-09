import Foundation

extension Double {

  func kelvinToFarenheit() -> String {
    let temperature = 9 / 5 * (self - 273.15) + 32
    return String(format: "%.1f", temperature)
  }

  func kelvinToCelsius() -> String {
    let temperature = self - 273.15
    return String(format: "%.1f", temperature)
  }
  
  func farenheitToCelsius() -> String {
    let temperature = (self - 32) * 5 / 9
    return String(format: "%.1f", temperature)
  }

  func farenheitToKelvin() -> String {
    let temperature = (self - 32) * 5 / 9 - 273.15
    return String(format: "%.1f", temperature)
  }

  func celsiusToFarenheit() -> String {
    let temperature = self * 9 / 5 + 32
    return String(format: "%.1f", temperature)
  }

  func celsiusToKelvin() -> String {
    let temperature = self + 273.15
    return String(format: "%.1f", temperature)
  }
}
