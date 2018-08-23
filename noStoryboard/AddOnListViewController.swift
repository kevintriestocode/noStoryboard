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
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: .zero, style: .plain)
    
    tableView.delegate = self as? UITableViewDelegate
    tableView.dataSource = self as? UITableViewDataSource
    
    tableView.separatorStyle = .singleLine
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 60
    
    
    title = "Add On Things"
    
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    view.addSubview(tableView)
  }
  
  func setupConstraints() {
    tableView.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalTo(view)
    }
  }
}
