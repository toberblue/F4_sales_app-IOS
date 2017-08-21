//
//  F4UserModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 11/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation
import SwiftyJSON

enum UserVerifiedStatus: Int {
  case nonVerified
  case verified
}

class F4UserModel {
  var email: String!
  var username: String?
  var verificationStatus: UserVerifiedStatus!
  
  init(json: JSON) {
    self.email = json["email"].stringValue
    self.username = json["username"].string
    self.verificationStatus = UserVerifiedStatus(rawValue: json["mem_val"].int ?? 0)
  }
}
