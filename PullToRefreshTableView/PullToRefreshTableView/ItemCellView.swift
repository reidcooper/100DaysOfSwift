//
//  ItemCellView.swift
//  PullToRefreshTableView
//
//  Created by Reid Cooper on 4/18/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class ItemCellView: UITableViewCell {
  
  @IBOutlet weak var groceryItemLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  func configure(with groceryItem: String) {
    groceryItemLabel.text = groceryItem
  }
}
