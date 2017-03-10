//
//  ViewController.swift
//  TapOrHoldCounter
//
//  Created by Reid Cooper on 2/20/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIBarPositioningDelegate {
  
  @IBOutlet weak var tallyLabel: UILabel!
  @IBOutlet weak var tapOrHoldButton: UIButton!
  
  var count: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed))
    self.view.addGestureRecognizer(longPressRecognizer)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func resetButtonPressed(_ sender: Any) {
    reset()
    updateLabels()
  }
  
  @IBAction func tapButton(_ sender: Any) {
    increment()
    updateLabels()
  }
  
  func longPressed() {
    increment()
    updateLabels()
  }
  
  private func increment() {
    count += 1
  }
  
  private func reset() {
    count = 0
  }
  
  private func updateLabels() {
    tallyLabel.text = String(count)
  }
  
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
}

