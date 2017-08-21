//
//  F4RoundedTextField.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 8/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4RoundedTextField: UITextField {
  
  var currentColorScheme: F4UIColorScheme = .white {
    didSet {
      updateColorScheme(withScheme: currentColorScheme)
    }
  }
  
  let fillAlpha: CGFloat = 0.65
  var inputIsValid = true
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  func setupUI() {
    self.layoutIfNeeded()
    self.layer.borderWidth = 1
    self.layer.cornerRadius = self.frame.height/2
    self.textAlignment = .center
    updateColorScheme(withScheme: currentColorScheme)
  }
  
  func updateColorScheme(withScheme scheme: F4UIColorScheme) {
    switch scheme {
    case .orange:
      self.backgroundColor = Constants.Colors.mainOrange.withAlphaComponent(fillAlpha)
      self.layer.borderColor = Constants.Colors.mainOrange.cgColor
      self.tintColor = Constants.Colors.mainWhite
      self.textColor = Constants.Colors.mainWhite
      self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSForegroundColorAttributeName : Constants.Colors.mainWhite])
    case .white:
      self.backgroundColor = Constants.Colors.mainWhite.withAlphaComponent(fillAlpha)
      self.layer.borderColor = Constants.Colors.mainWhite.cgColor
      self.tintColor = Constants.Colors.mainOrange
      self.textColor = Constants.Colors.darkGrey
      self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSForegroundColorAttributeName : Constants.Colors.darkGrey])
    }
  }
  
  func invalidateInput(gentle: Bool = false) {
    self.inputIsValid = false
    if gentle {
      self.layer.borderColor = Constants.Colors.red.cgColor
    } else {
      self.text = ""
      self.layer.borderColor = Constants.Colors.red.cgColor
      self.shake()
    }
  }
  
  func validateInput() {
    self.inputIsValid = true
    self.layer.borderColor = currentColorScheme == .orange ? Constants.Colors.mainOrange.cgColor : Constants.Colors.mainWhite.cgColor
  }
}

