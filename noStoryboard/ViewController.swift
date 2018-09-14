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
  var addOnListViewLabel: UILabel!
  var toggleNavigationBarButton: UIButton!
  var toggleNavigationBarButtonLabel: UILabel!
  var highlightPraticeLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    screen = UIView()
    settingsLabel = UILabel()
    addOnListViewLabel = UILabel()
    toggleNavigationBarButton = UIButton()
    toggleNavigationBarButtonLabel = UILabel()
    highlightPraticeLabel = UILabel()
    
    title = "Page One"
    
    // setupSubviews
    addSubviews()
    
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isHidden = true
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
    addOnListViewLabel.text = "Add On List"
    addOnListViewLabel.textAlignment = .center
    
    addOnListViewLabel.backgroundColor = .gray
    addOnListViewLabel.layer.cornerRadius = 9
    
    addOnListViewLabel.layer.masksToBounds = true
    addOnListViewLabel.snp.makeConstraints { (make) in
      make.top.equalTo(settingsLabel.snp.bottom).offset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(screen)
    }
    
    let addOnListViewLabelGesture = UITapGestureRecognizer(target: self, action: #selector(addOnListViewLabelTapped))
    addOnListViewLabel.isUserInteractionEnabled = true
    addOnListViewLabel.addGestureRecognizer(addOnListViewLabelGesture)
  
    // MARK: - Toggle Navigation Bar
    toggleNavigationBarButton.addSubview(toggleNavigationBarButtonLabel)
    toggleNavigationBarButton.backgroundColor = .gray
    
    toggleNavigationBarButton.layer.masksToBounds = true
    toggleNavigationBarButton.layer.cornerRadius = 9
    
    toggleNavigationBarButton.snp.makeConstraints { (make) in
      make.top.equalTo(addOnListViewLabel.snp.bottom).offset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(screen)
    }
    
    toggleNavigationBarButton.addTarget(self, action: #selector(togglePurple), for: .touchDown)
    toggleNavigationBarButton.addTarget(self, action: #selector(togglePurple), for: .touchDragExit)
    toggleNavigationBarButton.addTarget(self, action: #selector(togglePurple), for: .touchDragEnter)
    
    toggleNavigationBarButtonLabel.text = "Toggle Navigation Bar"
    toggleNavigationBarButtonLabel.snp.makeConstraints { make in
      make.center.equalTo(toggleNavigationBarButton)
    }
    
    // MARK: - Highlight Practice Label
    highlightPraticeLabel.text = "Highlight Practice"
    highlightPraticeLabel.textAlignment = .center
    
    highlightPraticeLabel.backgroundColor = .gray
    highlightPraticeLabel.layer.cornerRadius = 9
    
    highlightPraticeLabel.layer.masksToBounds = true
    highlightPraticeLabel.snp.makeConstraints { (make) in
      make.top.equalTo(toggleNavigationBarButton.snp.bottom).offset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(screen)
    }
    
    let highlightPracticeLabelGesture = UITapGestureRecognizer(target: self, action: #selector(highlightPracticeLabelTapped))
    highlightPraticeLabel.isUserInteractionEnabled = true
    highlightPraticeLabel.addGestureRecognizer(highlightPracticeLabelGesture)
  }
  
  func addSubviews() {
    view.addSubview(screen)
    screen.addSubview(settingsLabel)
    screen.addSubview(addOnListViewLabel)
    screen.addSubview(toggleNavigationBarButton)
    screen.addSubview(highlightPraticeLabel)
    
    screen.backgroundColor = .white
    screen.snp.makeConstraints { (make) in
      make.top.equalTo(view)
      make.right.equalTo(view)
      make.left.equalTo(view)
      make.bottom.equalTo(view)
    }
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
  }
  public override func viewWillDisappear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = false
  }
  
  // MARK: - Push VCs in reponse to tap gesture
  @objc func settingsLabelTapped() {
    let settingsVC = SettingsViewController()
    self.navigationController?.pushViewController(settingsVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
  }
  
  @objc func addOnListViewLabelTapped() {
    let addOnListVC = AddOnListTableViewController()
    self.navigationController?.pushViewController(addOnListVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
  }
  
  // MARK: - Purple Toggle Function
  @objc func togglePurple() {
    if toggleNavigationBarButton.backgroundColor == .gray {
      toggleNavigationBarButton.backgroundColor = .purple
    } else {
      toggleNavigationBarButton.backgroundColor = .gray
    }
    if navigationController?.navigationBar.isHidden == true {
      navigationController?.navigationBar.isHidden = false
    } else {
      navigationController?.navigationBar.isHidden = true
    }
  }
  
  @objc func highlightPracticeLabelTapped() {
    let highlightPracticeVC = HighlightPractiveViewController()
    self.navigationController?.pushViewController(highlightPracticeVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .blackTranslucent
    self.navigationController?.navigationBar.tintColor = .white
  }
}
