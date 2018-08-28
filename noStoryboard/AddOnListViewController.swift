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

public class AddOnListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var tableView: UITableView!
  var addRowButton: UINavigationItem!
  var itemsToLoad: [String] = ["One", "Two", "Three"]
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)

    tableView.separatorStyle = .singleLine
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 60
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell") // renamed from .registerClass
    tableView.dataSource = self
    tableView.delegate = self

    view.addSubview(tableView) // Add Subview first - before making constraints - or else you'll get some error about constraints.
    tableView.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalTo(view)
    }

    title = "Add On Things"

    // This adds the nav bar right item for the AddOnListTableViewController
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTable))
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsToLoad.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    cell.textLabel?.text = self.itemsToLoad[indexPath.row]
    return cell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You have tapped table row: \(indexPath.row) and item: \(itemsToLoad[indexPath.row]).") // To console each time a cell is tapped.
  }

  
  @objc func editTable() {
    tableView.setEditing(true, animated: true)
    
  }
}
