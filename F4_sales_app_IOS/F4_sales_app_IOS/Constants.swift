//
//  Constants.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 7/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

struct Constants {
  
  struct Status {
    static let isProduction = false
  }
  
  struct URLs {
    static let devBaseURL         = "https://flip4.co/pm/flip/F4_api"
    static let productionBaseURL  = "https://flip4.co/flip/F4_api"
    static let apiBaseURL         = devBaseURL
  }
  
  struct ResponseCode {
    static let ok = "OK"
  }
  
  struct Colors {
    static let mainOrange = UIColor(red:0.99, green:0.50, blue:0.03, alpha:1.0)
    static let mainWhite  = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    static let darkGrey   = UIColor(red:0.42, green:0.42, blue:0.42, alpha:1.0)
    static let lightGrey  = UIColor(red:0.70, green:0.70, blue:0.70, alpha:1.0)
    static let red        = UIColor.red
  }
  
  struct Icons {
    static let defaultSize = CGSize(width: 30, height: 30)
  }
  
  struct Fonts {
    static let main     = UIFont.systemFont(ofSize: 20)
    static let mainBold = UIFont.boldSystemFont(ofSize: 20)
    
    struct SF {
      static let ultraLight = UIFont.systemFont(ofSize: 20, weight: UIFontWeightUltraLight)
      static let thin       = UIFont.systemFont(ofSize: 20, weight: UIFontWeightThin)
      static let regular    = UIFont.systemFont(ofSize: 20, weight: UIFontWeightRegular)
      static let medium     = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
      static let semiBold   = UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold)
      static let bold       = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
      static let heavy      = UIFont.systemFont(ofSize: 20, weight: UIFontWeightHeavy)
      static let black      = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
    }
  }
  
  struct Storyboards {
    struct Main {
      static let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
      // Reveal menu
      static let revealMenuVC = "F4MenuViewController"
    }
    
    struct Calculator {
      static let storyboard = UIStoryboard(name: "Calculator", bundle: nil)
      
      // Navigation & VCs
      static let calculatorNavVC  = "F4CalculatorNavigationController"
      static let calculatorVC     = "F4CalculatorViewController"
    }
    
    struct SignIn {
      static let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
      
      // Navigation & VCs
      static let loginWrapperVC = "F4LoginWrapperViewController"
      static let loginDetailsVC = "F4LoginDetailsViewController"
      static let signingInVC    = "F4SigningInViewController"
    }
  }
  
  struct MenuItems {
    static let numberOfItems = 1
    
    struct Calculator {
      static let index = 0
      static let label = "Calculator"
    }
  }
  
  struct Notifications {
    static let clearSignUpUserInput = "F4ClearSignUpUserInput"
    static let signInStateChanged   = "F4signInStateChanged"
  }
  
  struct Dashboard {
    static let hintsSection     = 0
    static let myShopsSection   = 1
    static let mapSection       = 2
    static let websiteSection   = 3
    static let tipsSection      = 4
    static let newsSection      = 5
    static let contactUsSection = 6
    
    static let myShopsTitle     = "My Flip4 stores"
    static let mapTitle         = "Flip4 stores near me"
    static let moreInfoTitle    = "About Flip4"
    
    static let numberOfSections = 7
    
    static let maxRecentCards   = 5
  }
  
  struct ShopDetail {
    static let cardsSection     = 0
    static let promoSection     = 1
    static let mapSection       = 2
    // Optional, not statically rendered by default
    static let moreInfoSection  = 3
    
    static let numberOfSections = 3
  }
  
  struct WebLinks {
    static let flip4Website = "https://www.flip4.co"
    static let contactUs    = "https://www.flip4.co/contact"
    static let news         = "https://www.flip4.co/pm/news"
    static let tips         = "https://www.flip4.co/pm/tips"
  }
  
  struct Policies {
    static let minimumPasswordLength = 6
    static let minimumUsernameLength = 3
  }
}
