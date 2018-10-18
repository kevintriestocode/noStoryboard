//
//  GoogleAPICall.swift
//  noStoryboard
//
//  Created by Kevin Wang on 10/18/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//
import Alamofire
import ObjectMapper

public class GoogleAPICall: AnyAPI {
  var settings: Settings?
  public var request: DataRequest!
  public var response: (DataResponse<Any>)!
  public var responseObject: GoogleResponse?

  override public init() {
    super.init()

    settings = Settings()
    settings?.loadSettings()

    baseURL = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?")
    baseParameters = Parameters()
    baseParameters["address"] = settings?.zipCode
    baseParameters["key"] = settings?.googleAPIKey

    request = Alamofire.request(baseURL, method: .get, parameters: baseParameters, encoding: URLEncoding.queryString, headers: nil)
    print(request!)
    request.responseJSON(completionHandler: { res in
      self.response = res
      print(self.response.result.value)
    })
  }
}
