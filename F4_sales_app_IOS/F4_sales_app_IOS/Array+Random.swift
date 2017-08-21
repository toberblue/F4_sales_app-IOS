//
//  Array+Random.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 12/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation

extension Array {
  func randomItem() -> Element {
    let index = Int(arc4random_uniform(UInt32(self.count)))
    return self[index]
  }
}
