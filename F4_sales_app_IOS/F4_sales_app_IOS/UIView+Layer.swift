//
//  UIView+Layer.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 19/06/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

extension UIView {
  func addShadow() {
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 2)
    self.layer.shadowOpacity = 0.5
    self.layer.shadowRadius = 2
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
  }
  
  func roundCorners(withRadius radius: CGFloat = 8) {
    self.layer.cornerRadius = radius
  }
}
