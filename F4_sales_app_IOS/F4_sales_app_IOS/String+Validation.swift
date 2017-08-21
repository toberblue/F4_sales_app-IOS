//
//  String+Validation.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 12/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation

extension String {
  func isWhitespace() -> Bool {
    let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed.isEmpty
  }
  
  func isValidEmail() -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
}
