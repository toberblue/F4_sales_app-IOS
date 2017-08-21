//
//  F4AdModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 8/07/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation
import SwiftyJSON

class F4AdModel {
  var adUID: String
  var adURL: URL?
  var adTapURL: URL?
  var dateIssued: Date
  
  init(withJson json: JSON) {
    self.adUID = json["ad_uid"].stringValue
    self.adURL = URL(string: json["ad_url"].stringValue)
    self.adTapURL = URL(string: json["ad_tap_url"].stringValue)
    self.dateIssued = Date()
  }
}
