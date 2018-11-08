//
//  BaseAPI.swift
//  noStoryboard
//
//  Created by Kevin Wang on 10/18/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//
import Alamofire

public class AnyAPI {
  var baseURL: URL!
  var baseParameters: Parameters!
  var baseHeaders: HTTPHeaders!

  var settings: Settings!

  public init() {
    self.baseParameters = Parameters()
    self.baseHeaders = HTTPHeaders()

    self.settings = Settings.sharedSettings
    self.settings.loadSettings()
  }

  public func URLString() -> String? {
    return request(baseURL,
                   method: .get,
                   parameters: baseParameters,
                   encoding: URLEncoding.queryString,
                   headers: baseHeaders
      )
      .request?.description ?? nil
  }
}
