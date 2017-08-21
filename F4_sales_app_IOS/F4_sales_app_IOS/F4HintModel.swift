//
//  F4HintModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 19/06/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4HintModel {
  var hintText: String?
  var hintImage: UIImage?
  
  init(withHint hint: String, withImage image: UIImage) {
    self.hintText = hint
    self.hintImage = image
  }
}
