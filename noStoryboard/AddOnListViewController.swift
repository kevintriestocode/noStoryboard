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
  var itemsToLoad: [String] = dataSource
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)

    tableView.separatorStyle = .singleLine
    tableView.rowHeight = 60
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
  
  // Number of Rows
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsToLoad.count
  }

  // Cells' text == itemsToLoad values
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    cell.textLabel?.text = itemsToLoad[indexPath.row]
    return cell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You have tapped table row: \(indexPath.row), item name: \(itemsToLoad[indexPath.row]).") // To console each time a cell is tapped.
  }
  
  // Drag function.
  public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedObjTemp = itemsToLoad[sourceIndexPath.item]
    itemsToLoad.remove(at: sourceIndexPath.item)
    itemsToLoad.insert(movedObjTemp, at: destinationIndexPath.item)
  }
  
  // Mark: Delete function works! But isn't persistent
  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      print("Deleted row [\(indexPath.row)], item name: \(itemsToLoad[indexPath.row]).")
      
      self.itemsToLoad.remove(at: indexPath.item)
      self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    if editingStyle == .insert {
      print("insert")
    }
  }
  
  // Mark: Editing function
  @objc func editTable() {
    if tableView.isEditing == false {
      tableView.setEditing(true, animated: true)
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(editTable))
    } else {
      tableView.setEditing(false, animated: true)
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTable))
    }
  }
}
