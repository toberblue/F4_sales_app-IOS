//
//  F4CalculatorOptionsViewController.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 21/08/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4CalculatorOptionsViewController: F4BaseViewController {
  
  @IBOutlet weak var budgetButton: F4RoundedButton!
  @IBOutlet weak var impressionsButton: F4RoundedButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Calculator"
    loadMenuButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if !F4UserManager.shared.isUserLoggedIn() {
      F4UserManager.shared.attemptAutoSignIn { (success) in
        if !success {
          if !F4UserManager.shared.hasAutoPresentedSignIn {
            F4MenuManager.sharedManager.presentLogin()
          }
        }
      }
    }
  }
  
  @IBAction func budgetTapped(_ sender: Any) {
    let calcVC = Constants.Storyboards.Calculator.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.Calculator.calculatorVC) as! F4CalculatorViewController
    navigationController?.pushViewController(calcVC, animated: true)
  }
  
  @IBAction func impressionsTapped(_ sender: Any) {
  }
  
}
