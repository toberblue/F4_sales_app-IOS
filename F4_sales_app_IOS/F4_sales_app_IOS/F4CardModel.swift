//
//  F4CardModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 26/06/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation
import SwiftyJSON

struct F4CardModel {
  var setToFlip: Int
  var shopOdds: String?
  var backgroundColor: String?
  var accentColor: UIColor
  var maxLosingStreak: Int
  var cardImageURLStr: String?
  var stampImageURLStr: String?
  var stampWinImageURLStr: String?
  var flipWinsStamp: String?
  var flips: [F4FlipModel] = []
  
  init(json: JSON) {
    self.setToFlip            = Int(json["set_to_flip"].stringValue) ?? 1
    self.shopOdds             = json["shop_odds"].string
    self.backgroundColor      = json["card_bg_colour"].string
    self.accentColor          = json["accent_colour"].string?.hexStringToUIColor() ?? .gray
    self.maxLosingStreak      = Int(json["max_losing_streak"].stringValue)! // TODO: Ensure this is safe
    self.cardImageURLStr      = json["card_img_url"].string
    self.stampImageURLStr     = json["stamp_url"].string
    self.stampWinImageURLStr  = json["stamp_win_url"].string
    self.flipWinsStamp        = json["flip_wins_stamp"].string
    
    if let flipsJsonArray = json["flips"].array {
      for flipJson in flipsJsonArray {
        self.flips.append(F4FlipModel(json: flipJson))
      }
    }    
  }
  
  func getStampsRemainingString() -> String {
    if flips.count == 0 {
      return ""
    }
    
    let numRemaining = maxLosingStreak - flips.count
    if numRemaining == 0 {
      return "The next one's a winner!"
    } else {
      return "\(numRemaining) \(numRemaining > 1 ? "stamps" : "stamp") to go"
    }
  }
}

enum FlipResult: Int {
  case tryAgain = 0
  case win = 1
}

struct F4FlipModel {
  var result: FlipResult = .tryAgain
  var timeFlipped: Int?
  
  init(json: JSON) {
    if let resultInt = Int(json["f4_res"].stringValue) {
      self.result = FlipResult(rawValue: resultInt) ?? .tryAgain
    }
    self.timeFlipped = json["f4_ts"].int
  }
}
