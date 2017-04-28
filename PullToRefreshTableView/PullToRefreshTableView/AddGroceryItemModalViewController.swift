//
//  AddGroceryItemModalViewController.swift
//  PullToRefreshTableView
//
//  Created by Reid Cooper on 4/20/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

protocol AddGroceryItemModalViewControllerDelegate: class {
  func addGroceryItem(_ addGroceryItemModal: AddGroceryItemModalViewController, didFinishText text: String)
}

class AddGroceryItemModalViewController: UIViewController {
  
  weak var delegate: AddGroceryItemModalViewControllerDelegate?
  
  @IBOutlet weak var enterItemTextField: UITextField!
  @IBOutlet weak var doneButton: UIButton!
  
  @IBAction func cancelButton(_ sender: UIButton) {
    onCancelDone()
  }
  
  @IBAction func doneButton(_ sender: UIButton) {
    onCaptureTextDone()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    modalPresentationStyle = UIModalPresentationStyle.custom
    transitioningDelegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    doneButton.isEnabled = false
    
    enterItemTextField.delegate = self
    
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCancelDone))
    gestureRecognizer.cancelsTouchesInView = false
    gestureRecognizer.delegate = self
    view.addGestureRecognizer(gestureRecognizer)
    
    enterItemTextField.becomeFirstResponder()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func onCaptureTextDone() {
    guard let text = captureText() else {
      return
    }
    
    // send text
    delegate?.addGroceryItem(self, didFinishText: text)
    dismiss(animated: true, completion: nil)
  }
  
  private func captureText() -> String? {
    return enterItemTextField.text
  }
  
  @objc private func onCancelDone() {
    dismiss(animated: true, completion: nil)
  }
}

extension AddGroceryItemModalViewController: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return BounceAnimationController()
  }
}

extension AddGroceryItemModalViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return (touch.view === self.view)
  }
}

extension AddGroceryItemModalViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText = textField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    
    doneButton.isEnabled = (newText.length > 0)
    
    return true
    
  }
}
