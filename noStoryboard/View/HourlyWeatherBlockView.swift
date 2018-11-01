//
//  HourlyWeatherBlockView.swift
//  noStoryboard
//
//  Created by Kevin Wang on 10/24/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import UIKit
import SnapKit

class HourlyWeatherBlock: UIStackView {
  var hour: UILabel!
  var temp: UILabel!

  convenience init() {
    self.init(frame: .zero)

    hour = UILabel()
    temp = UILabel()

    self.addArrangedSubview(hour)
    self.addArrangedSubview(temp)

    self.axis = .vertical
    self.alignment = .center
    self.snp.makeConstraints { make in
      make.height.width.equalTo(40)
    }
  }
}
