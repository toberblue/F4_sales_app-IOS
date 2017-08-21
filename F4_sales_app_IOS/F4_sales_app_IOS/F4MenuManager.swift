//
//  F4MenuManager.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 7/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4MenuManager: NSObject,SSASideMenuDelegate {
  static let sharedManager = F4MenuManager()
  
  let menuVC     = F4MenuViewController.getInstance()
  var sideMenu:SSASideMenu?
  
  fileprivate override init() {
    super.init()
  }
  
  func instantiateSideMenu(shouldLoadHome: Bool = false) -> SSASideMenu {
    self.sideMenu =  SSASideMenu(contentViewController: UIViewController(), leftMenuViewController: menuVC)
    self.sideMenu!.configure(SSASideMenu.MenuViewEffect(fade: true, scale: false, scaleBackground: false))
    // Get the actual size of the window before pushing this out
    let appDelegate = UIApplication.shared.delegate
    var width:CGFloat = 0
    if let window = appDelegate?.window {
      width = (window?.frame.size.width)!
    }
    
    let offset:Float = Float(width)/1.25
    print("The width is \(width) and the offset is \(offset)")
    
    self.sideMenu!.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 1.0, landscapeOffsetX: 100, portraitOffsetX: 100, minParallaxContentRelativeValue: 0, maxParallaxContentRelativeValue: 0, interactivePopGestureRecognizerEnabled: true))
    self.sideMenu!.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 2.0))
    
    self.sideMenu?.delegate = menuVC
    
    if shouldLoadHome {
      loadCalculatorViewController()
    }
    
    return self.sideMenu!
  }
  
  // MARK: Load content View Controllers
  
  func updateContentVC(contentVC:UIViewController, requiresLogin: Bool = false) {
    if requiresLogin && !F4UserManager.shared.isUserLoggedIn() {
      presentLogin()
    } else {
      self.sideMenu?.contentViewController = contentVC
      self.sideMenu!.panGestureEnabled = true
      self.sideMenu?.hideMenuViewController()
    }
  }
  
  func presentLogin() {
    let loginVC = Constants.Storyboards.SignIn.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.SignIn.loginWrapperVC) as! F4LoginWrapperViewController
    self.sideMenu?.present(loginVC, animated: true, completion: nil)
  }
  
  func loadCalculatorViewController() {
    let homeVC = Constants.Storyboards.Calculator.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.Calculator.calculatorNavVC) as! UINavigationController
    updateContentVC(contentVC: homeVC)
  }
  
  // MARK: Class functions
  
  func toggleMenu() {
    if (self.sideMenu?.isMenuShown())! {
      self.sideMenu?.hideMenuViewController()
    } else {
      self.sideMenu?.presentLeftMenuViewController()
    }
  }
}
