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
 
  var tableView: UITableView!
  var addRowButton: UINavigationItem!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: .zero, style: .plain)
    
    tableView.delegate = self as? UITableViewDelegate
    tableView.dataSource = self as? UITableViewDataSource
    
    tableView.separatorStyle = .singleLine
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 60
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalTo(view)
    }
    
    title = "Add On Things"
    
    // This adds the nav bar right item for the AddOnListTableViewController
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(editTable))
  }
  
  @objc func editTable() {
    tableView.setEditing(true, animated: true)
  }
}
