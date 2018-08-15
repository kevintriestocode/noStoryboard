//
//  AddOnListViewController.swift
//  noStoryboard
//
//  Created by Kevin Wang on 8/15/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class AddOnListTableViewController: UIViewController {
 
  var screen: UIView!
  var tableView: UITableView!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    screen = UIView()
    tableView = UITableView()
    
    title = "Add On Things"
    
    view.addSubview(screen)
    
    screen.backgroundColor = .white
    screen.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalTo(view)
    }
    screen.addSubview(tableView)
    
    tableView.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalTo(screen)
    }
  }
}
