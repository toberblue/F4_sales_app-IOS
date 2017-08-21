//
//  F4ShopDetailModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 22/06/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation
import SwiftyJSON
import FontAwesome_swift

struct F4ShopDetailModel {
  var shopId:       String
  var chainId:      String?
  var shopName:     String
  var chainName:    String?
  var shopPhone:    String?
  var latitude:     Double?
  var longitude:    Double?
  var country:      String?
  var region:       String?
  var town:         String?
  var logoURLStr:   String?
  var promoText:    String?
  
  var cards: [F4CardModel] = []
  
  init(json: JSON) {
    self.shopId     = json["shop_id"].stringValue
    self.chainId    = json["chain_id"].string
    self.shopName   = json["shop_name"].stringValue
    self.chainName  = json["chain_name"].string
    self.shopPhone  = json["shop_phone"].string
    self.latitude   = Double(json["sb_lat"].stringValue)
    self.longitude  = Double(json["sb_long"].stringValue)
    self.country    = json["country"].string
    self.region     = json["region"].string
    self.town       = json["town"].string
    self.logoURLStr = json["sm_logo_url"].string
    self.promoText  = json["sb_tx_1"].string
  }
  
  func getLocalityString() -> String {
    if let town = self.town, let region = self.region {
      return "\(town), \(region)"
    }
    return ""
  }
  
  func getAvailableInfo() -> [F4InfoModel] {
    var info: [F4InfoModel] = []
    let iconSize = Constants.Icons.defaultSize
    
    if shopPhone != nil && shopPhone != "" {
      info.append(F4InfoModel(withInfoLabel: shopPhone!, withInfoIcon: UIImage.fontAwesomeIcon(name: .phone, textColor: Constants.Colors.mainOrange, size: iconSize), withActionType: .phoneNumber))
    }
    
    return info
  }
}
