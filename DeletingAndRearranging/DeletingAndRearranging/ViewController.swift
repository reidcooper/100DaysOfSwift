//
//  ViewController.swift
//  DeletingAndRearranging
//
//  Created by Reid Cooper on 4/28/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  var listArray = [String]()
  
  struct TableViewCellIdentifiers {
    static let primaryCell = "primaryCell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    navigationItem.leftBarButtonItem = editButtonItem
    
    populateArray()
    
    /*
     // Many view controllers have a view that may be in an editing state or not- for example, a UITableView.  These view
     // controllers can track the editing state, and generate an Edit|Done button to be used in a navigation bar.
     extension UIViewController {
     
     
     open var isEditing: Bool
     
     open func setEditing(_ editing: Bool, animated: Bool) // Updates the appearance of the Edit|Done button item as necessary. Clients who override it must call super first.
     
     
     open var editButtonItem: UIBarButtonItem { get } // Return an Edit|Done button that can be used as a navigation item's custom view. Default action toggles the editing state with animation.
     }
     */
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private func populateArray() {
    listArray.append("Flour")
    listArray.append("Milk")
    listArray.append("Eggs")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.primaryCell, for: indexPath)
    
    let item = listArray[indexPath.row]
    
    let label = cell.viewWithTag(1000) as! UILabel
    
    label.text = item
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return self.isEditing
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let origin_location = sourceIndexPath.row
    let destination_location = destinationIndexPath.row
    let itemToMove = listArray[origin_location]
    
    listArray.remove(at: origin_location)
    
    listArray.insert(itemToMove, at: destination_location)
  }
}
