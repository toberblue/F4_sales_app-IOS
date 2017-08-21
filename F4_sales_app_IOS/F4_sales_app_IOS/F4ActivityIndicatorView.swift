//
//  F4ActivityIndicatorView.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 26/06/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4ActivityIndicatorView: UIActivityIndicatorView {
  
  override init(frame: CGRect) { // for using CustomView in code
    super.init(frame: frame)
    self.commonInit()
  }
  
  required init(coder aDecoder: NSCoder) { // for using CustomView in IB
    super.init(coder: aDecoder)
    self.commonInit()
  }
  
  func commonInit() {
    self.color = Constants.Colors.mainOrange
    self.hidesWhenStopped = true
    self.startAnimating()
  }
  
}
