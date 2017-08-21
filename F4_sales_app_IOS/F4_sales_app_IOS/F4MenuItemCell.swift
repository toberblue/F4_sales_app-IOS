//
//  F4MenuItemCell.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 7/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4MenuItemCell: UITableViewCell {
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var itemLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }
  
  func setupUI() {
    itemLabel.textColor = Constants.Colors.mainWhite
    selectionStyle = .none
  }
  
  class func getNib() -> UINib {
    return UINib(nibName: "F4MenuItemCell", bundle: nil)
  }
  
  class func getReuseID() -> String {
    return "F4MenuItemCell"
  }
  
}
