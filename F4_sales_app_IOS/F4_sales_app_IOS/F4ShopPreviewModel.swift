//
//  F4ShopPreviewModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 19/06/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation
import SwiftyJSON

struct F4ShopPreviewModel {
  var id:         Int
  var name:       String
  var logoURLStr: String?
  var largeLogoURLStr: String?
  var latitude:   Double?
  var longitude:  Double?
  var distance:   Double?
  var lastSeen:   Int
  
  init(json: JSON) {
    self.id         = json["shop_id"].intValue
    self.name       = json["shop_name"].stringValue
    self.logoURLStr = json["sm_logo_url"].string
    self.largeLogoURLStr = json["lg_logo_url"].string
    self.latitude   = Double(json["lat"].stringValue)
    self.longitude  = Double(json["lon"].stringValue)
    self.distance   = Double(json["dist"].stringValue)
    self.lastSeen   = json["last_seen"].int ?? 0
  }
  
  var nameFirstLetter: String {
    return String(self.name[self.name.startIndex]).uppercased()
  }
}
