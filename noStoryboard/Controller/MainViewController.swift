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

class MainViewController: UIViewController {
  var settingsLabel: UILabel!
  var tableViewLabel: UILabel!
  var highlightPracticeLabel: UILabel!
  var weatherLabel: UILabel!
  var settings: Settings!

  override func viewDidLoad() {
    super.viewDidLoad()
    print("MainViewController did load")
    settingsLabel = UILabel()
    tableViewLabel = UILabel()
    highlightPracticeLabel = UILabel()
    weatherLabel = UILabel()
    settings = Settings()
    
    settings.loadSettings()

    title = "Main"

    consoleGreeting()
    setupViews()
    setupGestures()
  }
  
  // MARK: - Add Subviews
  func setupViews() {
    view.addSubview(settingsLabel)
    view.addSubview(tableViewLabel)

    view.addSubview(highlightPracticeLabel)
    view.addSubview(weatherLabel)

    view.backgroundColor = Configuration.Color.backgroundColor

    // Navigation Controller
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isHidden = false

    // Settings Label
    settingsLabel.text = "Settings"
    settingsLabel.textAlignment = .center

    settingsLabel.backgroundColor = .white
    settingsLabel.layer.cornerRadius = Configuration.Label.cornerRadius

    settingsLabel.layer.masksToBounds = true
    settingsLabel.snp.makeConstraints { (make) in
      make.centerX.equalTo(view)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
      make.width.equalTo(view).inset(5)
      make.height.equalTo(100)
    }

    // Table View Label
    tableViewLabel.text = "Add On List"
    tableViewLabel.textAlignment = .center

    tableViewLabel.backgroundColor = .white
    tableViewLabel.layer.cornerRadius = Configuration.Label.cornerRadius

    tableViewLabel.layer.masksToBounds = true
    tableViewLabel.snp.makeConstraints { (make) in
      make.top.equalTo(settingsLabel.snp.bottom).offset(5)
      make.width.equalTo(view).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(view)
    }

    // Highlight Practice Label
    highlightPracticeLabel.text = "Core Text Programming Guide 2-1"
    highlightPracticeLabel.textAlignment = .center

    highlightPracticeLabel.backgroundColor = .white
    highlightPracticeLabel.layer.cornerRadius = Configuration.Label.cornerRadius

    highlightPracticeLabel.layer.masksToBounds = true
    highlightPracticeLabel.snp.makeConstraints { (make) in
      make.top.equalTo(tableViewLabel.snp.bottom).offset(5)
      make.width.equalTo(view).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(view)
    }

    // MARK: - Weather Label
    weatherLabel.text = "Weather in Brooklyn?"
    weatherLabel.textAlignment = .center

    weatherLabel.backgroundColor = .white
    weatherLabel.layer.cornerRadius = Configuration.Label.cornerRadius

    weatherLabel.layer.masksToBounds = true
    weatherLabel.snp.makeConstraints { make in
      make.top.equalTo(highlightPracticeLabel.snp.bottom).offset(5)
      make.width.equalTo(view).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(view)
    }
  }

  func consoleGreeting() {
    if settings.username == nil || settings.username == "" {
      print("Oh hello! Who might you be?")
    } else {
      print("Welcome back \(settings.username!) \n")
    }
  }

  func setupGestures() {
    let settingsLabelGesture = UITapGestureRecognizer(target: self, action: #selector(settingsLabelTapped))
    settingsLabel.isUserInteractionEnabled = true
    settingsLabel.addGestureRecognizer(settingsLabelGesture)

    let tableViewLabelGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewLabelTapped))
    tableViewLabel.isUserInteractionEnabled = true
    tableViewLabel.addGestureRecognizer(tableViewLabelGesture)

    let highlightPracticeLabelGesture = UITapGestureRecognizer(target: self, action: #selector(highlightPracticeLabelTapped))
    highlightPracticeLabel.isUserInteractionEnabled = true
    highlightPracticeLabel.addGestureRecognizer(highlightPracticeLabelGesture)

    let morePracticeLabelGesture = UITapGestureRecognizer(target: self, action: #selector(weatherLabelTapped))
    weatherLabel.isUserInteractionEnabled = true
    weatherLabel.addGestureRecognizer(morePracticeLabelGesture)
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    
  }
  public override func viewWillDisappear(_ animated: Bool) {
    
  }
  
  // MARK: - Push VCs in reponse to tap gesture
  @objc func settingsLabelTapped() {
    let settingsVC = SettingsViewController()
    self.navigationController?.pushViewController(settingsVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
  }
  
  @objc func tableViewLabelTapped() {
    let addOnListVC = TableViewController()
    self.navigationController?.pushViewController(addOnListVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
  }
  
  // MARK: - Purple Toggle Function
//  @objc func togglePurple() {
//    if toggleNavigationBarButton.backgroundColor == .gray {
//      toggleNavigationBarButton.backgroundColor = .purple
//    } else {
//      toggleNavigationBarButton.backgroundColor = .gray
//    }
//    if navigationController?.navigationBar.isHidden == true {
//      navigationController?.navigationBar.isHidden = false
//    } else {
//      navigationController?.navigationBar.isHidden = true
//    }
//  }
  
  @objc func highlightPracticeLabelTapped() {
    let highlightPracticeVC = HighlightPractiveViewController()
    self.navigationController?.pushViewController(highlightPracticeVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
    self.navigationController?.navigationBar.tintColor = .white
  }
  
  @objc func weatherLabelTapped() {
    let weatherVC = WeatherViewController()
    self.navigationController?.pushViewController(weatherVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
    self.navigationController?.navigationBar.tintColor = .white
  }
}
