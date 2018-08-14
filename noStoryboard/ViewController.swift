//
//  ViewController.swift
//  noStoryboard
//
//  Created by Kevin Wang on 7/27/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

class ViewController: UIViewController {
  
  var screen: UIView!
  var centerLabel: UILabel!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    screen = UIView()
    centerLabel = UILabel()
        
    self.view.addSubview(screen)
    screen.addSubview(centerLabel)
    
    screen.backgroundColor = .white
    screen.snp.makeConstraints { (make) in
      make.top.equalTo(view)
      make.right.equalTo(view)
      make.left.equalTo(view)
      make.bottom.equalTo(view)
    }
        
    centerLabel.text = "Settings."
    centerLabel.textAlignment = .center
    centerLabel.backgroundColor = .gray
    centerLabel.snp.makeConstraints { (make) in
      make.center.equalTo(screen)
      make.width.equalTo(200)
      make.height.equalTo(100)
    }
    centerLabel.isUserInteractionEnabled = true
    let centerLabelGesture = UITapGestureRecognizer(target: self, action: #selector(centerLabelTapped))
    centerLabel.addGestureRecognizer(centerLabelGesture)
  }
  
  // MARK: - Push next VC to top of navigation stack
  @objc func centerLabelTapped() {
    
    let settingsVC = SettingsViewController()
    self.navigationController?.pushViewController(settingsVC, animated: true)
    
    // TODO: - Remove this
//    let phrases = [
//      "Ouch, you tapped me!",
//      "I'm over here!",
//      "Tap me, tap me!",
//      "Oh, too slow :P"
//    ]
//    centerLabel.text = phrases[Int(arc4random_uniform(4))]
//    centerLabel.snp.remakeConstraints { (make) in
//      make.centerX.equalTo(screen).offset(Int(arc4random_uniform(100))-Int(arc4random_uniform(100)))
//      make.centerY.equalTo(screen).offset(Int(arc4random_uniform(200))-Int(arc4random_uniform(200)))
//      make.width.equalTo(200)
//      make.height.equalTo(100)
//    }
  }
}
