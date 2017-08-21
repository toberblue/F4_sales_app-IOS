//
//  F4LoginWrapperViewController.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 8/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit
import FontAwesome_swift

protocol loginDetailsDelegate: class {
  func didEnterDetails(withUsername username: String, withPassword password: String)
  func createNewAccount(withUsername username: String, withPassword password: String)
  func didRequestPasswordReset(withEmail email: String)
  func shouldPresentSignUp()
  func shouldPresentSignIn()
  func shouldPresentForgot()
  func shouldOffsetContent(toOffset offset: CGFloat, animated: Bool)
}

class F4LoginWrapperViewController: F4BaseViewController {
  
  @IBOutlet weak var loginContainerView: UIView!
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var contentWrapper: UIView!
  @IBOutlet weak var contentWrapperTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var dismissButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let loginDetailsVC = Constants.Storyboards.SignIn.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.SignIn.loginDetailsVC) as! F4LoginDetailsViewController
    loginDetailsVC.loginDelegate = self
    loadContainer(withContent: loginDetailsVC, animated: false)
    
    setupUI()
  }
  
  deinit {
    print("F4LoginWrapperViewController: deinit")
  }
  
  // MARK: Auto-logging in
  override func viewDidAppear(_ animated: Bool) {
    //self.didEnterDetails(withUsername: "test2@apitestingd.co", withPassword: "test")
    //self.didEnterDetails(withUsername: "peter", withPassword: "pet123")
  }
  
  func loadContainer(withContent content: UIViewController, animated: Bool, withAnimationOption animationOption: UIViewAnimationOptions = .transitionFlipFromLeft) {
    content.view.tag = 100
    addChildViewController(content)
    content.view.frame = loginContainerView.bounds
    content.didMove(toParentViewController: self)
    
    if animated {
      UIView.transition(with: loginContainerView, duration: 0.5, options: animationOption, animations: { _ in
        for subView in self.loginContainerView.subviews {
          if subView.tag == 100 {
            subView.removeFromSuperview()
          }
        }
        self.loginContainerView.addSubview(content.view)
      }, completion: nil)
    } else {
      self.loginContainerView.addSubview(content.view)
    }
  }
  
  func setupUI() {
    // MARK: Causes memory leak when repeating
    //transitionBackgroundImage(repeated: true)
    
    self.dismissButton.setImage(UIImage.fontAwesomeIcon(name: .times, textColor: .white, size: CGSize(width: 35, height: 35)), for: .normal)
    self.dismissButton.addTarget(self, action: #selector(F4LoginWrapperViewController.dismissLogin), for: .touchUpInside)
  }
  
  func dismissLogin() {
    self.dismiss(animated: true, completion: nil)
  }
  
  func transitionBackgroundImage(repeated: Bool) {
    let randomImage = [#imageLiteral(resourceName: "loginBanner1"), #imageLiteral(resourceName: "loginBanner2"), #imageLiteral(resourceName: "loginBanner3"), #imageLiteral(resourceName: "loginBanner4")].randomItem()
    UIView.transition(with: self.backgroundImageView, duration: 5, options: .transitionCrossDissolve, animations: { 
      self.backgroundImageView.image = randomImage
    }) { (complete) in
      if repeated {
        //self.transitionBackgroundImage(repeated: repeated)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

/* Delegation extensions */

extension F4LoginWrapperViewController: loginDetailsDelegate {
  func didEnterDetails(withUsername username: String, withPassword password: String) {
    print("Logging in with username: \(username), and password: \(password)")
    F4UserManager.shared.signIn(withUsername: username, andPassword: password) { (error, success) in
      if success {
        self.dismiss(animated: true, completion: nil)
      } else {
        let alert = UIAlertController(title: "Login failed", message: "Please try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  
  func createNewAccount(withUsername username: String, withPassword password: String) {
    /*
    print("Creating account with username: \(username), and password: \(password)")
    F4UserManager.shared.signUp(withUsername: username, withPassword: password, shouldStoreCredentials: true) { (error, success, message) in
      if success {
        let alert = UIAlertController(title: "Sign up success", message: "(Message \(message ?? "{no message}"))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
          self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
      } else {
        
        let alert = UIAlertController(title: "Create account failed", message: "Please try again later. (Message \(message ?? "{no message}"))", preferredStyle: .alert)
        
        if message != nil && message!.contains("UE") {
          alert.message = "User already exists. Sign in instead?"
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.clearSignUpUserInput), object: nil)
          }))
          alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { (action) in
            self.shouldPresentSignIn()
          }))
        } else if message != nil && message!.contains("UNE") {
          alert.message = "Invalid username. Try an email instead?"
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.clearSignUpUserInput), object: nil)
          }))
        } else {
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.clearSignUpUserInput), object: nil)
          }))
        }
        self.present(alert, animated: true, completion: nil)
      }
    }
 */
  }
  
  func didRequestPasswordReset(withEmail email: String) {
    /*
    print("Requesting password reset for account with email: \(email)")
    F4UserManager.shared.forgotPassword(forUserWithEmail: email) { (error, success) in
      if success {
        print("Successfully requested password reset")
        let alert = UIAlertController(title: "Reset requested", message: "We've sent an email with reset instructions.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
          self.shouldPresentSignIn()
        }))
        self.present(alert, animated: true, completion: nil)
      } else {
        let alert = UIAlertController(title: "Reset request failed", message: "Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
 */
  }
  
  func shouldPresentSignUp() {
    /*
    let signUpVC = Constants.Storyboards.SignIn.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.SignIn.signUpVC) as! F4SignUpViewController
    signUpVC.loginDelegate = self
    loadContainer(withContent: signUpVC, animated: true)
 */
  }
  
  func shouldPresentSignIn() {
    let loginDetailsVC = Constants.Storyboards.SignIn.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.SignIn.loginDetailsVC) as! F4LoginDetailsViewController
    loginDetailsVC.loginDelegate = self
    loadContainer(withContent: loginDetailsVC, animated: true, withAnimationOption: .transitionFlipFromRight)
  }
  
  func shouldPresentForgot() {
    /*
    let forgotVC = Constants.Storyboards.SignIn.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.SignIn.forgotVC) as! F4ForgotViewController
    forgotVC.loginDelegate = self
    loadContainer(withContent: forgotVC, animated: true)
 */
  }
  
  func shouldOffsetContent(toOffset offset: CGFloat, animated: Bool) {
    contentWrapperTopConstraint.constant = offset
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}
