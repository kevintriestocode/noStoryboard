//
//  SettingsScrollView.swift
//  noStoryboard
//
//  Created by Kevin Wang on 10/13/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import Foundation
import SnapKit

class SettingsScrollView: UIScrollView {
  // TODO: - Abstract out these labels and fields into SettingsRow, SettingsCell, etc.
  var usernameLabel: UILabel!
  var usernameField: UITextField!

  var line1: LineView!

  var weatherAPILabel: UILabel!
  var weatherAPIField: UITextField!

  var line2: LineView!

  var googleAPILabel: UILabel!
  var googleAPIField: UITextField!

  var line3: LineView!

  var zipcodeLabel: UILabel!
  var zipcodeField: UITextField!

  override init(frame: CGRect) {
    super.init(frame: frame)

    usernameLabel = UILabel()
    usernameField = UITextField()

    line1 = LineView()
  
    weatherAPILabel = UILabel()
    weatherAPIField = UITextField()
  
    line2 = LineView()

    googleAPILabel = UILabel()
    googleAPIField = UITextField()

    line3 = LineView()

    zipcodeLabel = UILabel()
    zipcodeField = UITextField()

    setupViews()
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupViews() {
    backgroundColor = Configuration.Color.backgroundColor

    self.addSubview(usernameLabel)
    self.addSubview(usernameField)

    self.addSubview(line1)

    self.addSubview(weatherAPILabel)
    self.addSubview(weatherAPIField)

    self.addSubview(line2)

    self.addSubview(googleAPILabel)
    self.addSubview(googleAPIField)

    self.addSubview(line3)

    self.addSubview(zipcodeLabel)
    self.addSubview(zipcodeField)

    // Username Label
    usernameLabel.text = "Username"
    usernameLabel.font = UIFont.systemFont(ofSize: 18)

    usernameLabel.textColor = .white
    usernameLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.safeAreaLayoutGuide).offset(5)
      make.left.equalTo(self.safeAreaLayoutGuide).offset(5)
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
      make.left.equalTo(self.safeAreaLayoutGuide).offset(5)
    }

    // Line 1
    line1.snp.makeConstraints { make in
      make.top.equalTo(usernameField.snp.bottom).offset(5)
      make.width.equalTo(self.safeAreaLayoutGuide).inset(5)
      make.centerX.equalTo(self)
    }

    // Weather API Label
    weatherAPILabel.text = "Weather API Key"
    weatherAPILabel.font = UIFont.systemFont(ofSize: 18)

    weatherAPILabel.textColor = .white
    weatherAPILabel.textAlignment = .natural

    weatherAPILabel.snp.makeConstraints { make in
      make.top.equalTo(line1.snp.bottom).offset(5)
      make.left.equalTo(self.safeAreaLayoutGuide).offset(5)
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
      make.left.equalTo(self.safeAreaLayoutGuide).offset(5)
    }

    // Line 2
    line2.snp.makeConstraints { make in
      make.top.equalTo(weatherAPIField.snp.bottom).offset(5)
      make.width.equalTo(self.safeAreaLayoutGuide).inset(5)
      make.centerX.equalTo(self)
    }

    // Google API Label
    googleAPILabel.text = "Google API Key"
    googleAPILabel.font = UIFont.systemFont(ofSize: 18)

    googleAPILabel.textColor = .white
    googleAPILabel.textAlignment = .natural

    googleAPILabel.snp.makeConstraints { make in
      make.top.equalTo(line2.snp.bottom).offset(5)
      make.left.equalTo(self.safeAreaLayoutGuide).offset(5)
    }

    // Google API FIeld
    googleAPIField.isSecureTextEntry = true

    googleAPIField.autocapitalizationType = UITextAutocapitalizationType.none
    googleAPIField.autocorrectionType = UITextAutocorrectionType.no

    googleAPIField.borderStyle = UITextBorderStyle.roundedRect
    googleAPIField.backgroundColor = .white

    googleAPIField.adjustsFontSizeToFitWidth = true
    googleAPIField.textAlignment = .natural

    googleAPIField.snp.makeConstraints { make in
      make.top.equalTo(googleAPILabel.snp.bottom).offset(5)
      make.left.equalTo(self.safeAreaLayoutGuide).offset(5)
    }

    // Line 3
    line3.snp.makeConstraints { make in
      make.top.equalTo(googleAPIField.snp.bottom).offset(5)
      make.width.equalTo(self.safeAreaLayoutGuide).inset(5)
      make.centerX.equalTo(self)
    }

    // Zipcode Label
    zipcodeLabel.text = "Zipcode"
    zipcodeLabel.font = UIFont.systemFont(ofSize: 18)

    zipcodeLabel.textColor = .white
    zipcodeLabel.textAlignment = .natural

    zipcodeLabel.snp.makeConstraints { make in
      make.top.equalTo(line3.snp.bottom).offset(5)
      make.left.equalTo(self.safeAreaLayoutGuide).offset(5)
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
      make.left.equalTo(self.safeAreaLayoutGuide).offset(5)
    }
  }

  func configure() {
    isScrollEnabled = true
  }
}
