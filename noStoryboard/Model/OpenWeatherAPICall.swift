//
//  OpenWeatherAPICall.swift
//  noStoryboard
//
//  Created by Kevin Wang on 10/18/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//
import Alamofire
import ObjectMapper

public class OpenWeatherAPICall: AnyAPI {

  override public init() {
    super.init()

    baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?")

    baseParameters["lat"] = ""
    baseParameters["lon"] = "" // Be careful lon vs lng
    baseParameters["appid"] = settings?.weatherAPIKey
  }
}
