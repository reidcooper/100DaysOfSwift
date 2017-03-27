//
//  NotePreviewViewController.swift
//  PassingDataToAnotherView
//
//  Created by Reid Cooper on 3/21/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class NotePreviewViewController: UIViewController {
  
  @IBOutlet weak var notePreviewTextView: UITextView!
  
  var noteData: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Removes internal padding within the UITextView
    self.automaticallyAdjustsScrollViewInsets = false
    
    // Do any additional setup after loading the view.
    
    if let textToDisplay = noteData {
      notePreviewTextView.text = textToDisplay
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidLayoutSubviews() {
    self.notePreviewTextView.setContentOffset(CGPoint.zero, animated: false)
  }
}
