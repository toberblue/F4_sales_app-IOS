//
//  F4SFViewController.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 27/06/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit
import SafariServices

class F4SFViewController: SFSafariViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 10.0, *) {
      self.preferredControlTintColor = Constants.Colors.mainOrange
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    self.dismiss(animated: false, completion: nil)
  }
}
