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

public class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var tableView: UITableView!
  var settings: Settings!
  var tableData: [Any]?
  
  let cellID = "cellID"

  public override func viewDidLoad() {
    print("Table View did load")
    title = "Table View"

    settings = Settings.sharedSettings
    tableData = settings.tableData

    setupTableView()

    // This adds the nav bar right item for the TableViewController
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTable))
  }

  // MARK: - Add Table View to View
  func setupTableView() {

    // MARK: Initializing a UITableView Object
    tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    tableView.separatorStyle = .singleLine

    tableView.rowHeight = 60
    tableView.estimatedRowHeight = 60

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

    tableView.dataSource = self
    tableView.delegate = self

    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalTo(view)
    }
  }
  // MARK: - Providing the Table View Data
  // MARK: UITableViewDataSource
  // MARK: Configuring a Table View

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    cell.textLabel?.text = "\([indexPath])"
    return cell
  }
  
  // Tells the data source to return the number of rows in a given section of a table view.
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData?.count ?? 0
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

 
    }
    if editingStyle == .insert {

    }
  }

  public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
  }
  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  // MARK: Reordering Table Rows
  /// Drag function.
  public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
    
    
  }

  // MARK: - Customizing the Table View Behavior
  // MARK: [Pr]: UITableViewDelegate

  // MARK: Configuring Rows for the Table View

  // MARK: Managing Accessory Views
  public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    print("Accessory button has been tapped.")
  }

  // MARK: Managing Selections
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
  }

  // MARK: Modifying the Header and Footer of Sections

  // MARK: Editing Table Rows
  public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return .delete
  }

  // Changes swipe-delete-confirmation button text.
  public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    return "Woah, are you sure you want to delete?"
  }

  // MARK: Reordering Table Rows
  public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
    
    return proposedDestinationIndexPath
  }

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
}
