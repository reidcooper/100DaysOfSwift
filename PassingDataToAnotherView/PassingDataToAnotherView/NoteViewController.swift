//
//  ViewController.swift
//  PassingDataToAnotherView
//
//  Created by Reid Cooper on 3/21/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate, NotificationCenterManagerKeyboardProtocol {
  
  @IBOutlet weak var noteTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // Removes internal padding within the UITextView
    self.automaticallyAdjustsScrollViewInsets = false
    noteTextView.delegate = self
  
    let notificationCenterManager = NotificationCenterManager()
    notificationCenterManager.keyboardDelegate = self
    notificationCenterManager.registerKeyboardObserver()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func keyboardWillShow(_ notification: NSNotification) {
    print("Keyboard will show")
    animateViewOpenedKeyboard(true, duration: obtainKeyboardAnimationDuration(notification), distance: obtainKeyboardHeight(notification))
  }
  
  func keyboardWillHide(_ notification: NSNotification) {
    print("Keyboard will hide")
    animateViewOpenedKeyboard(false , duration: obtainKeyboardAnimationDuration(notification), distance: obtainKeyboardHeight(notification))
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowPreview" {
      
      let previewController = segue.destination as! NotePreviewViewController
      
      previewController.noteData = noteTextView.text
    }
  }
  
  // ScrollView does not scroll to top so first couple lines are cut off
  override func viewDidLayoutSubviews() {
    self.noteTextView.setContentOffset(CGPoint.zero, animated: false)
  }
  
  private func animateViewOpenedKeyboard(_ direction: Bool, duration timeInterval: TimeInterval?, distance moveRect: CGRect?) {
    guard let movementDuration = timeInterval, let distance = moveRect?.size.height else {
      return
    }
    
    let movement: CGFloat = direction ? -distance : distance
    
    UIView.beginAnimations("animateView", context: nil)
    UIView.setAnimationBeginsFromCurrentState(true)
    UIView.setAnimationDuration(movementDuration)
    
    noteTextView.frame.size.height = noteTextView.frame.size.height + movement
    
    UIView.commitAnimations()
  }
  
  private func obtainKeyboardHeight(_ notification: NSNotification) -> CGRect? {
    return notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect
  }
  
  private func obtainKeyboardAnimationDuration(_ notification: NSNotification) -> TimeInterval? {
    return notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
  }
}
