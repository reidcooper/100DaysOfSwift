//
//  ViewController.swift
//  CurrentDateAndTime
//
//  Created by Reid Cooper on 3/20/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var currentDateTitleLabel: UILabel!
  @IBOutlet weak var currentTimeLabel: UILabel!
  
  let timeBrainModel = TimeBrainModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setCurrentTimeLabel()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onRefreshButtonPressed(_ sender: Any) {
    setCurrentTimeLabel()
  }

  private func setCurrentTimeLabel() {
    currentTimeLabel.text = timeBrainModel.getTodayDate()
  }
}

