//
//  F4InfoModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 27/06/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

enum InfoActionType {
  case phoneNumber
  case emailAddress
  case webpage
  case rating
  
  case notSet
}

struct F4InfoModel {
  var infoLabel: String?
  var infoIcon: UIImage?
  var actionType: InfoActionType = .notSet
  
  // Default info init
  init(withInfoLabel infoLabel: String, withInfoIcon infoIcon: UIImage?, withActionType actionType: InfoActionType) {
    self.infoLabel = infoLabel
    self.infoIcon = infoIcon
    self.actionType = actionType
  }
  
  // Web info init
  var urlString: String?
  
  init(withWebPageLabel webpageLabel: String, withWebURL url: String, withInfoIcon infoIcon: UIImage?) {
    self.infoLabel = webpageLabel
    self.urlString = url
    self.infoIcon = infoIcon
    self.actionType = .webpage
  }
  
  // Rating info init
  var ratingShopPreview: F4ShopPreviewModel?
  
  init(withRatingLabel ratingLabel: String, withRatingShopPrev ratingShopPrev: F4ShopPreviewModel, withRatingIcon ratingIcon: UIImage?) {
    self.infoLabel = ratingLabel
    self.ratingShopPreview = ratingShopPrev
    self.infoIcon = ratingIcon
    self.actionType = .rating
  }
}
