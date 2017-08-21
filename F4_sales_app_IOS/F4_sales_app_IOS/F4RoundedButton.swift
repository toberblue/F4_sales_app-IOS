//
//  F4RoundedButton.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 8/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

enum F4UIColorScheme {
  case orange
  case white
}

class F4RoundedButton: UIButton {
  
  var currentColorScheme: F4UIColorScheme = .orange {
    didSet {
      updateColorScheme(withScheme: currentColorScheme)
    }
  }
  
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
    self.layer.cornerRadius = self.frame.height/2
    updateColorScheme(withScheme: currentColorScheme)
  }
  
  func updateColorScheme(withScheme scheme: F4UIColorScheme) {
    switch scheme {
    case .orange:
      self.backgroundColor = Constants.Colors.mainOrange
      self.tintColor = Constants.Colors.mainWhite
    case .white:
      self.backgroundColor = Constants.Colors.mainWhite
      self.tintColor = Constants.Colors.mainOrange
    }
  }
}
