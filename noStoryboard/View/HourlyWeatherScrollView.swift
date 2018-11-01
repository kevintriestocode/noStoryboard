//
//  HourlyWeatherScrollView.swift
//  noStoryboard
//
//  Created by Kevin Wang on 10/23/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import UIKit
import SnapKit

class HourlyWeatherScrollView: UIScrollView {
  convenience init() {
    self.init(frame: .zero)
    
    let hour0 = HourlyWeatherBlock()
    hour0.hour.text = "0"
    hour0.temp.text = "1º F"
    self.addSubview(hour0)
    hour0.snp.makeConstraints { make in
      make.left.equalTo(self)
    }

    let hour1 = HourlyWeatherBlock()
    hour1.hour.text = "1"
    hour1.temp.text = "1º F"
    self.addSubview(hour1)
    hour1.snp.makeConstraints { make in
      make.left.equalTo(hour0.snp.right)
    }

    let hour2 = HourlyWeatherBlock()
    hour2.hour.text = "2"
    hour2.temp.text = "1º F"
    self.addSubview(hour2)
    hour2.snp.makeConstraints { make in
      make.left.equalTo(hour1.snp.right)
    }
  }
}
