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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    screen = UIView()
    settingsLabel = UILabel()
    addOnListViewLabel = UILabel()
    
    view.addSubview(screen)
    screen.addSubview(settingsLabel)
    screen.addSubview(addOnListViewLabel)
    
    screen.backgroundColor = .white
    screen.snp.makeConstraints { (make) in
      make.top.equalTo(view)
      make.right.equalTo(view)
      make.left.equalTo(view)
      make.bottom.equalTo(view)
    }
        
    settingsLabel.text = "Settings"
    settingsLabel.textAlignment = .center
    settingsLabel.backgroundColor = .gray
    settingsLabel.snp.makeConstraints { (make) in
      make.centerX.equalTo(screen)
//      make.top.equalTo(self.topLayoutGuide.bottomAnchor as! ConstraintRelatableTarget)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
    }
    settingsLabel.isUserInteractionEnabled = true
    let settingsLabelGesture = UITapGestureRecognizer(target: self, action: #selector(settingsLabelTapped))
    settingsLabel.addGestureRecognizer(settingsLabelGesture)
    
    addOnListViewLabel.text = "Add On List"
    addOnListViewLabel.textAlignment = .center
    addOnListViewLabel.backgroundColor = .gray
    addOnListViewLabel.snp.makeConstraints { (make) in
      make.top.equalTo(settingsLabel.snp.bottom).offset(5)
      make.width.equalTo(screen).inset(5)
      make.height.equalTo(100)
      make.centerX.equalTo(screen)
    }
    addOnListViewLabel.isUserInteractionEnabled = true
    let addOnListViewLabelGesture = UITapGestureRecognizer(target: self, action: #selector(addOnListViewLabelTapped))
    addOnListViewLabel.addGestureRecognizer(addOnListViewLabelGesture)
  }
  
  // MARK: - Push next VC to top of navigation stack
  @objc func settingsLabelTapped() {
    let settingsVC = SettingsViewController()
    self.navigationController?.pushViewController(settingsVC, animated: true)
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
  }
  
  let addOnListVC = AddOnListTableViewController()
  
  @objc func addOnListViewLabelTapped() {
    self.navigationController?.pushViewController(addOnListVC, animated: true)
    self.navigationController?.title = "Add On Things"
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
  }
}
