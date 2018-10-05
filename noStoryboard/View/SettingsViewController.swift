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

  var usernameLabel: UILabel!
  var usernameField: UITextField!

  var weatherAPILabel: UILabel!
  var weatherAPIField: UITextField!

  var settings: Settings!

  public override func viewDidLoad() {
    print("SettingsViewController did load")

    settings = Settings()
    settings.loadSettings()

    if settings.username == nil || settings.username == "" {
      print("Pick a username")
    } else {
      print("Current username: \(UserDefaults.standard.string(forKey: "username")!)")
    }

    usernameLabel = UILabel()
    usernameField = UITextField()

    weatherAPILabel = UILabel()
    weatherAPIField = UITextField()

    title = "Settings"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    
    setupViews()
    setupDefaults()
  }

  func setupViews() {

    view.backgroundColor = Configuration.Color.backgroundColor

    view.addSubview(usernameLabel)
    view.addSubview(usernameField)
    view.addSubview(weatherAPILabel)
    view.addSubview(weatherAPIField)

    // Username Label
    usernameLabel.text = "Username"
    usernameLabel.snp.makeConstraints { (make) in
      make.center.equalTo(view)
    }

    // Username Field
    usernameField.autocapitalizationType = UITextAutocapitalizationType.none
    usernameField.autocorrectionType = UITextAutocorrectionType.no

    usernameField.borderStyle = UITextBorderStyle.roundedRect
    usernameField.backgroundColor = .white

    usernameField.textAlignment = .center
    usernameField.snp.makeConstraints { make in
      make.top.equalTo(usernameLabel.snp.bottom)
      make.width.greaterThanOrEqualTo(usernameLabel).offset(40)
      make.centerX.equalTo(usernameLabel)
    }

    // Weather API Label
    weatherAPILabel.text = "OpenWeather API Key"
    weatherAPILabel.textAlignment = .center
    weatherAPILabel.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.width.greaterThanOrEqualTo(usernameField.snp.width)
      make.top.equalTo(usernameField.snp.bottom).offset(10)
    }

    // Weather API Field
    weatherAPIField.autocapitalizationType = UITextAutocapitalizationType.none
    weatherAPIField.autocorrectionType = UITextAutocorrectionType.no

    weatherAPIField.borderStyle = UITextBorderStyle.roundedRect
    weatherAPIField.backgroundColor = .white

    weatherAPIField.textAlignment = .center
    weatherAPIField.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.width.greaterThanOrEqualTo(usernameField.snp.width)
      make.top.equalTo(weatherAPILabel.snp.bottom)
    }
  }

  func setupDefaults() {
    if settings.username == nil || settings.username == "" {
      usernameField.placeholder = "Who are you?"
    } else {
      usernameField.text = settings.username
    }

    if settings.weatherAPIKey == nil || settings.weatherAPIKey == "" {
      weatherAPIField.placeholder = "OpenWeather API Key"
    } else {
      weatherAPIField.text = settings.weatherAPIKey
    }
  }

  @objc func done() {
    settings.username = usernameField.text
    settings.weatherAPIKey = weatherAPIField.text
    settings.saveSettings()
    print("Username has been set to \(UserDefaults.standard.string(forKey: "username")!) \n")

    navigationController?.popViewController(animated: true)
  }
}
