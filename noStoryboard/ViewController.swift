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
  var purpleButton: UIButton!
  var buttonLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    screen = UIView()
    settingsLabel = UILabel()
    addOnListViewLabel = UILabel()
    purpleButton = UIButton()
    buttonLabel = UILabel()
    
    title = "Page One"
    
    view.addSubview(screen)
    screen.addSubview(settingsLabel)
    screen.addSubview(addOnListViewLabel)
    screen.addSubview(purpleButton)
    
    screen.backgroundColor = .white
    screen.snp.makeConstraints { (make) in
      make.top.equalTo(view)
      make.right.equalTo(view)
      make.left.equalTo(view)
      make.bottom.equalTo(view)
    }
    
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isHidden = true
    
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
    settingsLabel.isUserInteractionEnabled = true
    let settingsLabelGesture = UITapGestureRecognizer(target: self, action: #selector(settingsLabelTapped))
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
    addOnListViewLabel.isUserInteractionEnabled = true
    let addOnListViewLabelGesture = UITapGestureRecognizer(target: self, action: #selector(addOnListViewLabelTapped))
    addOnListViewLabel.addGestureRecognizer(addOnListViewLabelGesture)
  
    // MARK: - Alternate Settings Button
    purpleButton.addSubview(buttonLabel)
    purpleButton.backgroundColor = .gray
    purpleButton.layer.cornerRadius = 9
    purpleButton.layer.masksToBounds = true
    purpleButton.snp.makeConstraints { (make) in
      make.top.equalTo(addOnListViewLabel.snp.bottom).offset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(screen)
    }
    purpleButton.addTarget(self, action: #selector(togglePurple), for: .touchDown)
    purpleButton.addTarget(self, action: #selector(togglePurple), for: .touchDragExit)
    purpleButton.addTarget(self, action: #selector(togglePurple), for: .touchDragEnter)
    
    buttonLabel.text = "Toggle Navigation Bar"
    buttonLabel.snp.makeConstraints { make in
      make.center.equalTo(purpleButton)
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
    if purpleButton.backgroundColor == .gray {
      purpleButton.backgroundColor = .purple
    } else {
      purpleButton.backgroundColor = .gray
    }
    if navigationController?.navigationBar.isHidden == true {
      navigationController?.navigationBar.isHidden = false
    } else {
      navigationController?.navigationBar.isHidden = true
    }
  }
}
