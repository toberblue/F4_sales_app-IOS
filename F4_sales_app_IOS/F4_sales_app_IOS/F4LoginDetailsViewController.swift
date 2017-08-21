//
//  F4LoginDetailsViewController.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 8/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4LoginDetailsViewController: F4BaseViewController {
  
  @IBOutlet weak var usernameTextField: F4RoundedTextField!
  @IBOutlet weak var passwordTextField: F4RoundedTextField!
  @IBOutlet weak var signInButton: F4RoundedButton!
  @IBOutlet weak var createAccountButton: F4RoundedButton!
  
  weak var loginDelegate: loginDetailsDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    passwordTextField.currentColorScheme = .orange
    createAccountButton.currentColorScheme = .white
  }
  
  func isValidUsername() -> Bool {
    if usernameTextField.text != nil {
      // User may have entered a username or email
      if usernameTextField.text!.contains("@") {
        return !usernameTextField.text!.isWhitespace() && usernameTextField.text!.isValidEmail()
      } else {
        return !usernameTextField.text!.isWhitespace()
      }
    }
    return false
  }
  
  func isValidPassword() -> Bool {
    return !(passwordTextField.text ?? "").isEmpty
  }
  
  @IBAction func textFieldChanged(_ sender: F4RoundedTextField) {
    if sender == self.usernameTextField && isValidUsername() {
      self.usernameTextField.validateInput()
    } else if sender == self.passwordTextField && isValidPassword() {
      self.passwordTextField.validateInput()
    }
  }
  
  @IBAction func signInTapped(_ sender: Any) {
    var isValid = true
    
    if isValidUsername() {
      print("Is a valid username, \(String(describing: self.usernameTextField.text))")
    } else {
      isValid = false
      usernameTextField.invalidateInput()
    }
    
    if isValidPassword() {
      print("Is a valid password, \(String(describing: self.passwordTextField.text))")
    } else {
      isValid = false
      passwordTextField.invalidateInput()
    }
    
    if isValid {
      loginDelegate?.didEnterDetails(withUsername: self.usernameTextField.text!, withPassword: self.passwordTextField.text!)
    }
  }
  
  @IBAction func signUpTapped(_ sender: Any) {
    loginDelegate?.shouldPresentSignUp()
  }
  
  @IBAction func forgotTapped(_ sender: Any) {
    loginDelegate?.shouldPresentForgot()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

/* MARK: Delegation extensions */

extension F4LoginDetailsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
