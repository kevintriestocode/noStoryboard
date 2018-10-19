//
//  GoogleAPICall.swift
//  noStoryboard
//
//  Created by Kevin Wang on 10/18/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//
import Alamofire

public class GoogleAPICall: AnyAPI {

  override public init() {
    super.init()

    baseURL = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?")

    baseParameters["address"] = settings?.zipCode ?? nil
    baseParameters["key"] = settings?.googleAPIKey ?? nil
  }
}
