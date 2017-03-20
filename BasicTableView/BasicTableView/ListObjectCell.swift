//
//  ListObjectCell.swift
//  BasicTableView
//
//  Created by Reid Cooper on 3/13/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class ListObjectCell: UITableViewCell {
  
  @IBOutlet weak var Title: UILabel!
  @IBOutlet weak var subtitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure(for item: ListObject) {
    self.Title.text = item.subDetail
    self.subtitle.text = item.title
  }
}
