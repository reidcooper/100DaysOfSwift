//
//  NotificationCenterManager.swift
//  PassingDataToAnotherView
//
//  Created by Reid Cooper on 3/23/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import Foundation

class NotificationCenterManager {
  
  var keyboardDelegate: NotificationCenterManagerKeyboardProtocol?
  let defaultNotificationCenter = NotificationCenter.default
  
  init() {
    
  }
  
  func registerKeyboardObserver() {
    guard let delegate = keyboardDelegate else {
      print("No Keyboard Delegate")
      return
    }
    
    defaultNotificationCenter.addObserver(
      delegate,
      selector: #selector(delegate.keyboardWillShow(_:)),
      name: .UIKeyboardWillShow,
      object: nil
    )
    
    defaultNotificationCenter.addObserver(
      delegate,
      selector: #selector(delegate.keyboardWillHide(_:)),
      name: .UIKeyboardWillHide,
      object: nil
    )
  }
}

@objc
protocol NotificationCenterManagerKeyboardProtocol: class {
  func keyboardWillShow(_ notification: NSNotification)
  func keyboardWillHide(_ notification: NSNotification)
}
