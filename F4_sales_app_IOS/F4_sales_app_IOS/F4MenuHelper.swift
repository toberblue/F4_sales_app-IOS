//
//  F4MenuHelper.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 7/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation
import FontAwesome_swift

class F4MenuHelper: NSObject {
  
  class func GetMenuItemInfo(atIndexPath indexPath:IndexPath) -> (title: String, icon: FontAwesome) {
    var titleAndIconToReturn = (title: "Placeholder", icon: FontAwesome.navicon)
    
    switch indexPath.row {
    case Constants.MenuItems.Calculator.index:
      titleAndIconToReturn = (title: Constants.MenuItems.Calculator.label, icon: FontAwesome.calculator)
    default:
      print("Invalid menu item indexpath: \(indexPath.row)")
    }
    
    return titleAndIconToReturn
  }
  
  class func MenuItemTapped(atIndexPath indexPath: IndexPath) {
    switch indexPath.row {
    case Constants.MenuItems.Calculator.index:
      print("Calculator")
      F4MenuManager.sharedManager.loadCalculatorViewController()
      
    default:
      print("Invalid menu item indexpath: \(indexPath.row)")
    }
  }
}
