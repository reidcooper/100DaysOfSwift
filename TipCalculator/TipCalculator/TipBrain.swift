//
//  TipBrain.swift
//  TipCalculator
//
//  Created by Reid Cooper on 2/24/17.
//  Copyright © 2017 Reid Cooper. All rights reserved.
//

import Foundation

class TipBrain {

  // ============================
  
  var tipPercentage: Double = 0.0
  var tipAmount: Double = 0.0
  var billTotal: Double = 0.0
  var totalAmount: Double = 0.0
  
  var displayTipPercentage: String {
    return formmatNumberToPercentage(self.tipPercentage / 100)
  }
  
  var displayTipAmount: String {
    return formatNumberToCurrency(self.tipAmount)
  }
  
  var displayBillTotal: String {
    return formatNumberToCurrency(self.billTotal)
  }
  
  var displayTotalAmount: String {
    return formatNumberToCurrency(self.totalAmount)
  }

  private let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    
    print("created number formatter")
    
    return formatter
  }()
  
  private let percentageFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    
    formatter.usesGroupingSeparator = false
    formatter.maximumFractionDigits = 0
    formatter.minimumFractionDigits = 0
    formatter.numberStyle = .percent
    formatter.locale = Locale.current
    
    return formatter
  }()
  
  // ============================
  
  init(initialPercentage tip: Double) {
    tipPercentage = round(tip)
  }
  
  func calculateGrandtotal(amount billTotal: Double, tip tipPercent: Double) -> Double{
    self.billTotal = billTotal
    self.tipPercentage = round(tipPercent)
    
    self.tipAmount = calculateTipAmount(amount: self.billTotal, tip: self.tipPercentage)
    
    self.totalAmount = self.billTotal + self.tipAmount
    
    return self.totalAmount
  }
  
  func calculateTipAmount(amount billTotal: Double, tip tipPercent: Double) -> Double {
    return Double(billTotal * (tipPercent/100))
  }
  
  // ============================
  
  private func formmatNumberToPercentage(_ number: Double) -> String {
    let percentageString: String
    
    if let text = percentageFormatter.string(from: number as NSNumber) {
      percentageString = text
    } else {
      percentageString = ""
    }
    
    return percentageString
  }
  
  private func formatNumberToCurrency(_ number: Double) -> String {
    let currencyString: String
    
    if let text = currencyFormatter.string(from: number as NSNumber) {
      currencyString = text
    } else {
      currencyString = ""
    }
    
    return currencyString
  }
}
