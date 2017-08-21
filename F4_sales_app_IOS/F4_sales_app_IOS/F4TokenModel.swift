//
//  F4TokenModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 15/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation
import SwiftyJSON

class F4TokenModel {
  var value: String!
  var expiryDate: Date!
  
  init(json: JSON) {
    self.value = json["token"].stringValue
    
    let issuedDateNumSeconds = json["issue"].doubleValue
    let ttl = json["ttl"].doubleValue
    
    self.expiryDate = Date(timeIntervalSince1970: issuedDateNumSeconds + ttl)
  }
  
  func isExpired() -> Bool {
    return !(Date() < expiryDate)
  }
}
