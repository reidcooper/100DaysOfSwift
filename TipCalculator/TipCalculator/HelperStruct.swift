//
//  HelperStruct.swift
//  TipCalculator
//
//  Created by Reid Cooper on 2/24/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import Foundation
import UIKit

struct Helper {
  static func createAccessoryViewWithTarget(target: AnyObject, width: CGFloat) -> UIView {
    let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
    accessoryView.backgroundColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)
    
    let closeLabel = UILabel(frame: accessoryView.frame)
    closeLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
    closeLabel.text = "Done"
    closeLabel.textColor = UIColor.white
    closeLabel.textAlignment = NSTextAlignment.center
    
    accessoryView.addSubview(closeLabel)
    
    let closeButton = UIButton(frame: accessoryView.frame)
    
    let primaryViewController = target as! ViewController
    
    closeButton.addTarget(target, action: #selector(primaryViewController.finishEnteringBillAmount), for: UIControlEvents.touchUpInside)
    accessoryView.addSubview(closeButton)
    
    accessoryView.autoresizingMask = UIViewAutoresizing.flexibleWidth
    closeLabel.autoresizingMask = UIViewAutoresizing.flexibleWidth
    closeButton.autoresizingMask = UIViewAutoresizing.flexibleWidth
    
    return accessoryView
  }
}
