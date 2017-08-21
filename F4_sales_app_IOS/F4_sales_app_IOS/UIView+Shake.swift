//
//  UIView+Shake.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 12/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

extension UIView {
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = 0.6
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    layer.add(animation, forKey: "shake")
  }
}
