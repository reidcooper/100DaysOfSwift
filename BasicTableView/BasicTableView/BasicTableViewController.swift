//
//  ViewController.swift
//  BasicTableView
//
//  Created by Reid Cooper on 3/13/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class BasicTableViewController: UITableViewController {
  
  var basicList = [ListObject]()

  struct TableViewCellIdentifiers {
    static let listObjectCell = "ListObjectCell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    registerListObjectCellNib()
    
    navigationItem.leftBarButtonItem = editButtonItem
    
    populateBasicList()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Tell TableView how many to display
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return basicList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.listObjectCell, for: indexPath) as! ListObjectCell
    let item = basicList[indexPath.row]
    
    cell.configure(for: item)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == .delete) {
      basicList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  private func populateBasicList() {
    var tempListObject = ListObject(title: "Cat", detail: "Feline")
    basicList.append(tempListObject)
    
    tempListObject = ListObject(title: "Star Wars", detail: "Movie")
    basicList.append(tempListObject)
    
    tempListObject = ListObject(title: "Football", detail: "America")
    basicList.append(tempListObject)
    
    tempListObject = ListObject(title: "NYC", detail: "American City")
    basicList.append(tempListObject)
    
    tempListObject = ListObject(title: "Amtrak", detail: "Trains")
    basicList.append(tempListObject)
  }
  
  private func registerListObjectCellNib() {
    let cellNib = UINib(nibName: TableViewCellIdentifiers.listObjectCell, bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.listObjectCell)
  }
}

