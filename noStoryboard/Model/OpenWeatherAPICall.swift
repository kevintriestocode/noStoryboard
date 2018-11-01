//
//  OpenWeatherAPICall.swift
//  noStoryboard
//
//  Created by Kevin Wang on 10/18/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//
import Alamofire

public class OpenWeatherAPICall: AnyAPI {

  override public init() {
    super.init()

    baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?")

    baseParameters["lat"] = ""
    baseParameters["lon"] = "" // Be careful with lon(OpenWeatherMap) vs lng(Google)
    baseParameters["appid"] = settings.weatherAPIKey
  }

  func forecast() -> OpenWeatherAPICall {
    self.baseURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?")
    return self
  }

  func current() -> OpenWeatherAPICall {
    self.baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?")
    return self
  }
}
