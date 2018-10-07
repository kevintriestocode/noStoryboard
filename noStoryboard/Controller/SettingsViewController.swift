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

  var line1: LineView!
  
  var weatherAPILabel: UILabel!
  var weatherAPIField: UITextField!
  
  var line2: LineView!
  
  var zipcodeLabel: UILabel!
  var zipcodeField: UITextField!

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

    line1 = LineView()
    
    weatherAPILabel = UILabel()
    weatherAPIField = UITextField()
    
    line2 = LineView()
    
    zipcodeLabel = UILabel()
    zipcodeField = UITextField()

    title = "Settings"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    
    setupViews()
    setupDefaults()
  }

  func setupViews() {

    view.backgroundColor = Configuration.Color.backgroundColor

    view.addSubview(usernameLabel)
    view.addSubview(usernameField)

    view.addSubview(line1)
    
    view.addSubview(weatherAPILabel)
    view.addSubview(weatherAPIField)

    view.addSubview(line2)
    
    view.addSubview(zipcodeLabel)
    view.addSubview(zipcodeField)

    // Username Label
    usernameLabel.text = "Username"
    usernameLabel.font = UIFont.systemFont(ofSize: 18)

    usernameLabel.textColor = .white
    usernameLabel.snp.makeConstraints { (make) in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
    }

    // Username Field
    usernameField.autocapitalizationType = UITextAutocapitalizationType.none
    usernameField.autocorrectionType = UITextAutocorrectionType.no

    usernameField.adjustsFontSizeToFitWidth = true
    usernameField.borderStyle = UITextBorderStyle.roundedRect
    
    usernameField.backgroundColor = .white
    usernameField.textAlignment = .natural

    usernameField.snp.makeConstraints { make in
      make.top.equalTo(usernameLabel.snp.bottom).offset(5)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
    }
    // Line 1
    line1.snp.makeConstraints { make in
      make.top.equalTo(usernameField.snp.bottom).offset(5)
      make.width.equalTo(view.safeAreaLayoutGuide).inset(5)
      make.centerX.equalTo(view)
    }
    
    // Weather API Label
    weatherAPILabel.text = "API Key"
    weatherAPILabel.font = UIFont.systemFont(ofSize: 18)

    weatherAPILabel.textColor = .white
    weatherAPILabel.textAlignment = .natural

    weatherAPILabel.snp.makeConstraints { make in
      make.top.equalTo(line1.snp.bottom).offset(5)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
    }

    // Weather API Field
    weatherAPIField.isSecureTextEntry = true
    
    weatherAPIField.autocapitalizationType = UITextAutocapitalizationType.none
    weatherAPIField.autocorrectionType = UITextAutocorrectionType.no

    weatherAPIField.borderStyle = UITextBorderStyle.roundedRect
    weatherAPIField.backgroundColor = .white

    weatherAPIField.adjustsFontSizeToFitWidth = true
    weatherAPIField.textAlignment = .natural

    weatherAPIField.snp.makeConstraints { make in
      make.top.equalTo(weatherAPILabel.snp.bottom).offset(5)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
    }
    
    // Line 2
    line2.snp.makeConstraints { make in
      make.top.equalTo(weatherAPIField.snp.bottom).offset(5)
      make.width.equalTo(view.safeAreaLayoutGuide).inset(5)
      make.centerX.equalTo(view)
    }
    
    // Zipcode Label
    zipcodeLabel.text = "Zipcode"
    zipcodeLabel.font = UIFont.systemFont(ofSize: 18)
    
    zipcodeLabel.textColor = .white
    zipcodeLabel.textAlignment = .natural
    
    zipcodeLabel.snp.makeConstraints { make in
      make.top.equalTo(line2.snp.bottom).offset(5)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
    }

    // Zipcode Field
    zipcodeField.autocapitalizationType = UITextAutocapitalizationType.none
    
    zipcodeField.autocorrectionType = UITextAutocorrectionType.no
    zipcodeField.borderStyle = UITextBorderStyle.roundedRect
    
    zipcodeField.backgroundColor = .white
    zipcodeField.adjustsFontSizeToFitWidth = true
    
    zipcodeField.textAlignment = .natural
    zipcodeField.snp.makeConstraints { make in
      make.top.equalTo(zipcodeLabel.snp.bottom).offset(5)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(5)
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
    
    if settings.zipCode == nil || settings.zipCode == "" {
      zipcodeField.placeholder = "Enter your Zipcode"
    } else {
      zipcodeField.text = settings.zipCode
    }
  }

  @objc func done() {
    settings.username = usernameField.text
    settings.weatherAPIKey = weatherAPIField.text

    settings.zipCode = zipcodeField.text
    settings.saveSettings()

    print("Settings have been saved.")

    navigationController?.popViewController(animated: true)
  }
}
