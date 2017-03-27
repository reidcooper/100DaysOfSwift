//
//  ViewController.swift
//  SwipeToDismissKeyboard
//
//  Created by Reid Cooper on 3/27/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    textView.keyboardDismissMode = .interactive
    
    let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    swipe.direction = UISwipeGestureRecognizerDirection.down
    self.view.addGestureRecognizer(swipe)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func dismissKeyboard() {
    self.textView.resignFirstResponder()
  }
}

