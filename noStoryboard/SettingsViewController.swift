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
  var usernameLabel: UILabel!
  var usernameField: UITextField!
  
  var settings: Settings!
  
  public override func viewDidLoad() {
    settings = Settings()
    settings.loadSettings()
    print("current username: \(UserDefaults.standard.string(forKey: "username"))")
    
    print("SettingsViewController did load")
    screen = UIView()
    usernameLabel = UILabel()
    usernameField = UITextField()
    
    title = "Settings"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(confirm))
    
    
    view.addSubview(screen)
    
    screen.backgroundColor = .white
    screen.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalTo(view)
    }
    
    screen.addSubview(usernameLabel)
    screen.addSubview(usernameField)
    
    usernameLabel.text = "Username"
    usernameLabel.snp.makeConstraints { (make) in
      make.center.equalTo(view)
    }
    
    usernameField.autocapitalizationType = UITextAutocapitalizationType.none
    usernameField.autocorrectionType = UITextAutocorrectionType.no
    
    usernameField.borderStyle = UITextBorderStyle.roundedRect
    usernameField.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    
    usernameField.snp.makeConstraints { make in
      make.top.equalTo(usernameLabel.snp.bottom)
      make.width.equalTo(usernameLabel)
      make.centerX.equalTo(usernameLabel)
    }
    
    
    
    usernameField.text = settings.username // TODO: -
  }
  
  @objc func confirm() {
    settings.username = usernameField.text
    self.settings.saveSettings()
    print("username = \(settings.username)")
    print("username = \(UserDefaults.standard.string(forKey: "username"))")
  }
}
