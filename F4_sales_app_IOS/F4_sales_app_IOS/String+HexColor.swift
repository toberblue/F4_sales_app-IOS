//
//  String+HexColor.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 5/07/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

extension String {
  func hexStringToUIColor() -> UIColor {
    var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if cString == "0" {
      return .black
    }
    
    if ((cString.characters.count) != 6) {
      return .gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
