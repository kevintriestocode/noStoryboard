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
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Add On Things"

    setupTableView()
    
    // This adds the nav bar right item for the AddOnListTableViewController
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTable))
  }
  
  // MARK: - Add Table View to View
  func setupTableView() {
    
    // MARK: Initializing a UITableView Object
    tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    tableView.separatorStyle = .singleLine
    
    tableView.rowHeight = 60
    tableView.estimatedRowHeight = 60
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell") // renamed from .registerClass
    
    
    let dataSource: UITableViewDataSource = self
    tableView.dataSource = dataSource
    
    
    let delegate: UITableViewDelegate = self
    tableView.delegate = delegate
    
    view.addSubview(tableView) // Add Subview first - before making constraints - or else you'll get some error about constraints.
    tableView.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalTo(view)
    }
  }
  // MARK: - Providing the Table View Data
  // MARK: UITableViewDataSource
  // MARK: Configuring a Table View
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    cell.textLabel?.text = Configuration.dataSource[indexPath.row]
    return cell
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Configuration.dataSource.count
  }
  
  /// Asks the data source for the title of the header of the specified section of the table view.
  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    return "Header of section: \(section)"
  }
  
  /// Asks the data source for the title of the footer of the specified section of the table view.
  public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return "Footer of section: \(section)"
  }
  
  // MARK: Inserting or Deleting Table Rows
  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      print("Deleted row [\(indexPath.row)], item name: \(Configuration.dataSource[indexPath.row]).")
      
      Configuration.dataSource.remove(at: indexPath.item)
      self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    if editingStyle == .insert {
      print("insert")
    }
  }

  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  // MARK: Reordering Table Rows
  /// Drag function.
  public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedObjTemp = Configuration.dataSource[sourceIndexPath.item]
    Configuration.dataSource.remove(at: sourceIndexPath.item)
    Configuration.dataSource.insert(movedObjTemp, at: destinationIndexPath.item)
  }
  
  // MARK: - Customizing the Table View Behavior
  // MARK: [Pr]: UITableViewDelegate
  
  // MARK: Configuring Rows for the Table View
  
  // MARK: Managing Accessory Views
  
  // MARK: Managing Selections
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You have tapped table row: \(indexPath.row), item name: \(Configuration.dataSource[indexPath.row]).") // To console each time a cell is tapped.
  }
  public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    print("You have deselected table row: \(indexPath.row), item name: \(Configuration.dataSource[indexPath.row]).")
  }
  
  // MARK: Modifying the Header and Footer of Sections
  
  // MARK: Editing Table Rows
  public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    if Configuration.dataSource.count >= 5 {
      return .delete
    } else {
      return .insert
    }
  }
  
  public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    return "Woah, are you sure you want to delete?"
  }
  
  // MARK: Reordering Table Rows
  
  // MARK: Tracking the Removal of Views
  
  // MARK: Copying and Pasting Row Content
  
  // MARK: Managing Table View Highlighting
  
  // MARK: Managing Table View Focus
  
  // MARK: Handling Swipe Actions
  
  
  
  // MARK: - Edit
  @objc func editTable() {
    if tableView.isEditing == false {
      tableView.setEditing(true, animated: true)
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(editTable))
    } else {
      tableView.setEditing(false, animated: true)
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTable))
    }
  }
  
  @objc func add() {
    
  }
}
