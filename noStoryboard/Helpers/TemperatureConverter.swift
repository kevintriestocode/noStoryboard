import Foundation

extension Double {

  func kelvinToFarenheit() -> Double {
    let temperature = 9 / 5 * (self - 273.15) + 32
    return temperature
//    return String(format: "%.1f", temperature)
  }

  func kelvinToCelsius() -> Double {
    let temperature = self - 273.15
    return temperature
  }
  
  func farenheitToCelsius() -> Double {
    let temperature = (self - 32) * 5 / 9
    return temperature
  }

  func farenheitToKelvin() -> Double {
    let temperature = (self - 32) * 5 / 9 - 273.15
    return temperature
  }

  func celsiusToFarenheit() -> Double {
    let temperature = self * 9 / 5 + 32
    return temperature
  }

  func celsiusToKelvin() -> Double {
    let temperature = self + 273.15
    return temperature
  }

  func asString() -> String {
    return String(format: "%.1f", self)
  }
}
