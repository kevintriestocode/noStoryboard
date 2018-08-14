//
//  SettingsViewController.swift
//  noStoryboard
//
//  Created by Kevin Wang on 8/14/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
  
  var screen: UIView!
  var notice: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    screen = UIView()
    notice = UILabel()
    
    title = "Settings"
    
    view.addSubview(screen)
    
    screen.backgroundColor = UIColor(red: 70, green: 120, blue: 95, alpha: 1)
    screen.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalTo(view)
    }
    screen.addSubview(notice)
    
    notice.text = "Oops! No settings have been established."
    notice.snp.makeConstraints { (make) in
      make.center.equalTo(view)
    }
  }
}
