//
//  F4BaseViewController.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 7/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4BaseViewController: UIViewController {
  
  var wasPushed = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    /* Setup default navigation bar appearance */
    self.navigationController?.navigationBar.isTranslucent = false
  }
  
  func loadMenuButton() {
    if self.navigationController != nil {
      let menuButton = UIBarButtonItem()
      
      let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 25)] as [String: Any]
      menuButton.setTitleTextAttributes(attributes, for: .normal)
      menuButton.title = String.fontAwesomeIcon(name: .reorder)
      menuButton.target = self
      menuButton.action = #selector(F4BaseViewController.toggleMenu)
      
      self.navigationItem.leftBarButtonItem = menuButton
    }
  }
  
  func presentAlert(withTitle title: String?, withMessage message: String?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func toggleMenu() {
    print("Toggling the menu..")
    F4MenuManager.sharedManager.toggleMenu()
  }
}

/*
extension F4BaseViewController: GenericContentDelegate {
  func didSelect(infoItem: F4InfoModel) {
    switch infoItem.actionType {
    case .webpage:
      if let urlString = infoItem.urlString, let url = URL(string: urlString) {
        let safVC = F4SFViewController(url: url)
        present(safVC, animated: true, completion: nil)
      }
    case .rating:
      if let ratingShopPreview = infoItem.ratingShopPreview {
        let ratingVC = Constants.Storyboards.Shop.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.Shop.shopRatingVC) as! F4ShopRatingViewController
        ratingVC.loadedShopPreview = ratingShopPreview
        self.navigationController?.pushViewController(ratingVC, animated: true)
      }
      
    default:
      print("F4BaseViewController: unrecognized info model type selected")
    }
  }
}

extension F4BaseViewController: AdPresenterDelegate {
  func adWillAppear(withFrame frame: CGRect) {
    print("Ad will appear")
  }
  
  func adWillDisappear() {
    print("ad will disappear")
  }
  
  func adDidClickThrough(withURL url: URL, withUID uid: String) {
    let safVC = F4SFViewController(url: url)
    present(safVC, animated: true, completion: nil)
    
    F4AdManager.shared.reportClickThrough(forAdWithUID: uid, withAdTapURL: url.absoluteString)
  }
}
*/
