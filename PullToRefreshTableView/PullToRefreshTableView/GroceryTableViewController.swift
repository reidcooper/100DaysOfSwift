//
//  ViewController.swift
//  PullToRefreshTableView
//
//  Created by Reid Cooper on 4/18/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class GroceryTableViewController: UITableViewController {
  
  var listArray = [String]()
  var listToAddAgain = [String]()
  
  struct GroceryTableViewIdentifiers {
    static let itemCellView = "ItemCellView"
  }
  
  struct GroceryTableViewSegueIdentifiers {
    static let presentAddGroceryItemModalView = "PresentAddGroceryItemModalView"
  }
  
  @IBAction func editButton(_ sender: UIBarButtonItem) {
  }
  
  @IBAction func addButton(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: GroceryTableViewSegueIdentifiers.presentAddGroceryItemModalView, sender: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    loadGroceryItemCellNib()
    
    self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    
    navigationItem.leftBarButtonItem = editButtonItem
    
    populateListArray()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GroceryTableViewIdentifiers.itemCellView, for: indexPath) as! ItemCellView
    
    let groceryItem = listArray[indexPath.row]
    
    cell.configure(with: groceryItem)
    
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
      listToAddAgain.append(listArray.remove(at: indexPath.row))
      tableView.deleteRows(at: [indexPath], with: .bottom)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == GroceryTableViewSegueIdentifiers.presentAddGroceryItemModalView {
      let destinationController = segue.destination as! AddGroceryItemModalViewController
      destinationController.delegate = self
    }
  }
  
  func handleRefresh(_ refreshControl: UIRefreshControl) {
    //    https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/
    listArray.append(contentsOf: listToAddAgain)
    listToAddAgain.removeAll()
    
    listArray.sort() { $0 < $1}
    
    self.tableView.reloadData()
    self.refreshControl?.endRefreshing()
  }
  
  private func populateListArray() {
    listArray.append("Milk")
    listArray.append("Apples")
    listArray.append("Ham")
    listArray.append("Eggs")
    
    listArray.sort() { $0 < $1}
  }
  
  private func loadGroceryItemCellNib() {
    let cellNib = UINib(nibName: GroceryTableViewIdentifiers.itemCellView, bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: GroceryTableViewIdentifiers.itemCellView)
  }
}

extension GroceryTableViewController: AddGroceryItemModalViewControllerDelegate {
  func addGroceryItem(_ addGroceryItemModal: AddGroceryItemModalViewController, didFinishText text: String) {
    addNewGroceryItemToArray(text)
    tableView.reloadData()
  }
  
  private func addNewGroceryItemToArray(_ text: String) {
    listArray.append(text)
  }
}
