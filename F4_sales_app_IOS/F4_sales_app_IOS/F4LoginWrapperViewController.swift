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
  func shouldPresentSignIn()
  func shouldOffsetContent(toOffset offset: CGFloat, animated: Bool)
}

class F4LoginWrapperViewController: F4BaseViewController {
  
  @IBOutlet weak var loginContainerView: UIView!
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var contentWrapper: UIView!
  @IBOutlet weak var contentWrapperTopConstraint: NSLayoutConstraint!

  
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
    
//    self.dismissButton.setImage(UIImage.fontAwesomeIcon(name: .times, textColor: .white, size: CGSize(width: 35, height: 35)), for: .normal)
//    self.dismissButton.addTarget(self, action: #selector(F4LoginWrapperViewController.dismissLogin), for: .touchUpInside)
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
  
  func shouldPresentSignIn() {
    let loginDetailsVC = Constants.Storyboards.SignIn.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.SignIn.loginDetailsVC) as! F4LoginDetailsViewController
    loginDetailsVC.loginDelegate = self
    loadContainer(withContent: loginDetailsVC, animated: true, withAnimationOption: .transitionFlipFromRight)
  }
  
  func shouldOffsetContent(toOffset offset: CGFloat, animated: Bool) {
    contentWrapperTopConstraint.constant = offset
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}
