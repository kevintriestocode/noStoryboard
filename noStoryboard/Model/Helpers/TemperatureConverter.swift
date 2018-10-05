import Foundation

extension Double {

  func kelvinToFarenheit() -> String {
    let temperature = 9 / 5 * (self - 273.15) + 32
    return String(format: "%.1f", temperature) + " ºF"
  }

  func kelvinToCelsius() -> String {
    let temperature = self - 273.15
    return String(format: "%.1f", temperature) + " ºC"
  }
  
  func farenheitToCelsius() -> String {
    let temperature = (self - 32) * 5 / 9
    return String(format: "%.1f", temperature) + " ºC"
  }

  func farenheitToKelvin() -> String {
    let temperature = (self - 32) * 5 / 9 - 273.15
    return String(format: "%.1f", temperature) + " ºK"
  }

  func celsiusToFarenheit() -> String {
    let temperature = self * 9 / 5 + 32
    return String(format: "%.1f", temperature) + " ºF"
  }

  func celsiusToKelvin() -> String {
    let temperature = self + 273.15
    return String(format: "%.1f", temperature) + " ºK"
  }
}
