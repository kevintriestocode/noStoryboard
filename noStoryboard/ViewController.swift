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
  var settingsLabel: UILabel!
  var tableViewLabel: UILabel!
  var highlightPracticeLabel: UILabel!
  var morePracticeLabel: UILabel!
  
  var settings: Settings!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("ViewController did load")
    screen = UIView()
    settingsLabel = UILabel()
    tableViewLabel = UILabel()
    highlightPracticeLabel = UILabel()
    morePracticeLabel = UILabel()
    
    settings = Settings()
    settings.loadSettings()
    
    if settings.username == nil || settings.username == "" {
      print("Oh hello! Who might you be?")
    } else {
      print("Welcome back \(settings.username!) \n")
    }
    
    title = "Page One"
    
    // setupSubviews
    addSubviews()
    
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: nil)
    
    // MARK: - Settings Label
    settingsLabel.text = "Settings"
    settingsLabel.textAlignment = .center
    
    settingsLabel.backgroundColor = .gray
    settingsLabel.layer.cornerRadius = 9
    
    settingsLabel.layer.masksToBounds = true
    settingsLabel.snp.makeConstraints { (make) in
      make.centerX.equalTo(screen)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
    }

    let settingsLabelGesture = UITapGestureRecognizer(target: self, action: #selector(settingsLabelTapped))
    settingsLabel.isUserInteractionEnabled = true
    settingsLabel.addGestureRecognizer(settingsLabelGesture)
    
    // MARK: - Add On List Label
    tableViewLabel.text = "Add On List"
    tableViewLabel.textAlignment = .center
    
    tableViewLabel.backgroundColor = .gray
    tableViewLabel.layer.cornerRadius = 9
    
    tableViewLabel.layer.masksToBounds = true
    tableViewLabel.snp.makeConstraints { (make) in
      make.top.equalTo(settingsLabel.snp.bottom).offset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(screen)
    }
    
    let tableViewLabelGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewLabelTapped))
    tableViewLabel.isUserInteractionEnabled = true
    tableViewLabel.addGestureRecognizer(tableViewLabelGesture)
    
    // MARK: - Highlight Practice Label
    highlightPracticeLabel.text = "Core Text Programming Guide 2-1"
    highlightPracticeLabel.textAlignment = .center
    
    highlightPracticeLabel.backgroundColor = .gray
    highlightPracticeLabel.layer.cornerRadius = 9
    
    highlightPracticeLabel.layer.masksToBounds = true
    highlightPracticeLabel.snp.makeConstraints { (make) in
      make.top.equalTo(tableViewLabel.snp.bottom).offset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(screen)
    }
    
    let highlightPracticeLabelGesture = UITapGestureRecognizer(target: self, action: #selector(highlightPracticeLabelTapped))
    highlightPracticeLabel.isUserInteractionEnabled = true
    highlightPracticeLabel.addGestureRecognizer(highlightPracticeLabelGesture)
    
    // MARK: - More Practice Label
    morePracticeLabel.text = "Core Text Programming Guide 2-2"
    morePracticeLabel.textAlignment = .center
    
    morePracticeLabel.backgroundColor = .gray
    morePracticeLabel.layer.cornerRadius = 9
    
    morePracticeLabel.layer.masksToBounds = true
    morePracticeLabel.snp.makeConstraints { make in
      make.top.equalTo(highlightPracticeLabel.snp.bottom).offset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(screen)
    }
    
    let morePracticeLabelGesture = UITapGestureRecognizer(target: self, action: #selector(morePracticeLabelTapped))
    morePracticeLabel.isUserInteractionEnabled = true
    morePracticeLabel.addGestureRecognizer(morePracticeLabelGesture)
  }
  
  // MARK: - Add Subviews
  func addSubviews() {
    view.addSubview(screen)
    
    screen.addSubview(settingsLabel)
    screen.addSubview(tableViewLabel)

    screen.addSubview(highlightPracticeLabel)
    screen.addSubview(morePracticeLabel)
    
    screen.backgroundColor = .white
    screen.snp.makeConstraints { (make) in
      make.top.equalTo(view)
      make.right.equalTo(view)
      make.left.equalTo(view)
      make.bottom.equalTo(view)
    }
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
  
  @objc func morePracticeLabelTapped() {
    let morePracticeVC = MorePracticeViewController()
    self.navigationController?.pushViewController(morePracticeVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
    self.navigationController?.navigationBar.tintColor = .white
  }
}
