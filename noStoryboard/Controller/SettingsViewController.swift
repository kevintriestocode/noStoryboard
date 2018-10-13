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

public class SettingsViewController: UIViewController, UIScrollViewDelegate {
  var settingsScrollView: SettingsScrollView!
  var settings: Settings!

  public override func viewDidLoad() {
    print("SettingsViewController did load")
    settingsScrollView = SettingsScrollView()
    
    settings = Settings()
    settings.loadSettings()

    if settings.username == nil || settings.username == "" {
      print("Pick a username")
    } else {
      print("Current username: \(UserDefaults.standard.string(forKey: "username")!)")
    }

    title = "Settings"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

    setupViews()
    setupDefaults()
  }

  func setupViews() {
    view.addSubview(settingsScrollView)
    
    settingsScrollView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
      make.edges.equalTo(view)
    }

  }
  func setupDefaults() {
    if settings.username == nil || settings.username == "" {
      settingsScrollView.usernameField.placeholder = "Who are you?"
    } else {
      settingsScrollView.usernameField.text = settings.username
    }

    if settings.weatherAPIKey == nil || settings.weatherAPIKey == "" {
      settingsScrollView.weatherAPIField.placeholder = "OpenWeather API Key"
    } else {
      settingsScrollView.weatherAPIField.text = settings.weatherAPIKey
    }

    if settings.googleAPIKey == nil || settings.googleAPIKey == "" {
      settingsScrollView.googleAPIField.placeholder = "Google API Key"
    } else {
      settingsScrollView.googleAPIField.text = settings.googleAPIKey
    }

    if settings.zipCode == nil || settings.zipCode == "" {
      settingsScrollView.zipcodeField.placeholder = "Enter your Zipcode"
    } else {
      settingsScrollView.zipcodeField.text = settings.zipCode
    }
  }

  @objc func done() {
    settings.username = settingsScrollView.usernameField.text
    settings.weatherAPIKey = settingsScrollView.weatherAPIField.text

    settings.googleAPIKey = settingsScrollView.googleAPIField.text
    settings.zipCode = settingsScrollView.zipcodeField.text

    settings.saveSettings()

    print("Settings have been saved.")

    navigationController?.popViewController(animated: true)
  }
}
