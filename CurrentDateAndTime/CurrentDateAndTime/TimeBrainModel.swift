//
//  TimeBrainModel.swift
//  CurrentDateAndTime
//
//  Created by Reid Cooper on 3/20/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import Foundation

class TimeBrainModel {
  func getTodayDate() -> String {
    let output = formatDate(with: "MMMM dd yyyy, h:mm:ss a")

    print(output)
    
    return output
  }
  
  private func formatDate(with dateString: String) -> String{
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = dateString
    
    return dateFormatter.string(from: currentDate)
  }
}
