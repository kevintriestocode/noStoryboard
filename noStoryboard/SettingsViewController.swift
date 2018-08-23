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

public class SettingsViewController: UIViewController {
  
  var screen: UIView!
  var notice: UILabel!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    screen = UIView()
    notice = UILabel()
    
    title = "Settings"
    
    view.addSubview(screen)
    
    screen.backgroundColor = .white
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
