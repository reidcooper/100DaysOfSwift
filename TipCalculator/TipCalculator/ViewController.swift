//
//  ViewController.swift
//  TipCalculator
//
//  Created by Reid Cooper on 2/21/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var billTotalTextField: UITextField!
  @IBOutlet weak var tipPercentLabel: UILabel!
  @IBOutlet weak var tipAmountLabel: UILabel!
  @IBOutlet weak var totalAmountLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  
  var tipBrain: TipBrain!
  
  var trimmedDisplayedBillSubtotal: Double? {
    let currentAmount: Double?
    
    if let aString = billTotalTextField.text {
      let tempString = aString.replacingOccurrences(of: "$", with: "")
      let removeCommas = tempString.replacingOccurrences(of: ",", with: "")
      
      if let tempDouble = Double(removeCommas) {
        currentAmount = tempDouble
      } else {
        currentAmount = nil
      }
      
    } else {
      currentAmount = nil
    }
    
    return currentAmount
  }
  
  var selectedTipPercentage: Double {
    let currentPercentage: Double
    
    currentPercentage = Double(slider.value)

    return currentPercentage
  }
  
  @IBAction func sliderChangedValue(_ sender: UISlider) {
    callToCalculate()
    toDisplay()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    billTotalTextField.delegate = self
    
    tipBrain = TipBrain(initialPercentage: selectedTipPercentage)
    
    slider.isEnabled = false
    displayTipAttributes()
    displayBillGrandtotal()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func finishEnteringBillAmount() {
    billTotalTextField.resignFirstResponder()
    slider.isEnabled = true
    callToCalculate()
    toDisplay()
  }
  
  private func callToCalculate() {
    if let amount = trimmedDisplayedBillSubtotal {

      let tip = selectedTipPercentage

      let _ = tipBrain.calculateGrandtotal(amount: amount, tip: tip)
    }
  }
  
  private func toDisplay() {
    displayBillSubtotal()
    displayTipAttributes()
    displayBillGrandtotal()
  }
  
  private func displayBillSubtotal() {
    billTotalTextField.text = tipBrain.displayBillTotal
  }
  
  private func displayTipAttributes() {
    tipPercentLabel.text = "Tip (\(tipBrain.displayTipPercentage))"
    tipAmountLabel.text = tipBrain.displayTipAmount
  }
  
  private func displayBillGrandtotal() {
    totalAmountLabel.text = tipBrain.displayTotalAmount
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if(textField.inputAccessoryView == nil) {
      textField.inputAccessoryView = Helper.createAccessoryViewWithTarget(target: self, width: self.view.frame.width)
    }
    
    slider.isEnabled = false
    
    return true
  }
}

extension ViewController: UIBarPositioningDelegate {
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
}
