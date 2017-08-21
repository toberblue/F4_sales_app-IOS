//
//  F4UserManager.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 11/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class F4UserManager {
  static let shared = F4UserManager()
  
  // This prevents using the '()' initializer for somewhere else
  fileprivate init() {}
  
  private var authToken: F4TokenModel?
  private var isLoggedIn = false
  private let keychainManager = HFKeychainManager()
  
  var loggedInUser: F4UserModel?
  var hasAutoPresentedSignIn = false
 
  /* MARK: User API functions */
  
  func attemptAutoSignIn(responseBlock: @escaping (_ success: Bool) -> Void) {
    self.keychainManager.attemptAutoSignIn { (success) in
      responseBlock(success)
    }
  }
  
  func signOut() {
    self.isLoggedIn = false
    self.loggedInUser = nil
    self.keychainManager.clearStoredCredentials()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.signInStateChanged), object: nil)
    F4MenuManager.sharedManager.loadCalculatorViewController()
  }
  
  func signIn(withUsername username: String, andPassword password: String, shouldStoreCredentials storeCredentials: Bool = true, responseBlock:@escaping (_ error: Error?, _ succeeded: Bool) -> ()) {
    
    let endpointURL = Constants.URLs.apiBaseURL + "/user_login"
    Alamofire.request(endpointURL, method: .post, parameters: ["username_email":username,"pwd":password], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
      
      switch response.result {
      case .success(let data):
        
          let json = JSON(data)
          let authJson = json["auth_response"]
          let tokenJson = authJson["token"]
          
          if tokenJson["token"].string != nil && json["f4_response_code"].intValue == 200 {
            let token = F4TokenModel(json: tokenJson)
            print("This token expires at: \(token.expiryDate!), with value: \(token.value!)")
            
            self.authToken = token
            self.isLoggedIn = true
            self.loggedInUser = F4UserModel(json: authJson["user_model"])
            
            if storeCredentials {
              self.keychainManager.storeCredentials(username: username, password: password)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.signInStateChanged), object: nil)
            responseBlock(nil, true)
          } else {
            print("F4UserManager: No valid auth token received, with f4_response_code: \(json["f4_response_code"].string ?? "{no code provided}") with error: \(json["error"].string ?? "{no error provided}")")
            responseBlock(nil, false)
          }
        
      case .failure(let error):
        responseBlock(error, false)
      }
    }
  }
  
  /* Authentication functions */
  
  func isUserLoggedIn() -> Bool {
    return self.isLoggedIn && authToken != nil && keychainManager.credentialsStored()
  }
  
  func areCredentialsStored() -> Bool {
    return self.keychainManager.credentialsStored()
  }
  
  func prepareAuthHeader(responseBlock:@escaping (_ error: Error?, _ succeeded: Bool, _ header: [String:String]) -> ()) {
    if isUserLoggedIn() {
      if authToken!.isExpired() {
        // Token was expired - refresh token
        let storedCredentials = keychainManager.retrieveStoredCredentials()
        signIn(withUsername: storedCredentials.username, andPassword: storedCredentials.password, responseBlock: { (error, success) in
          if success {
            print("F4UserManager: Successfully refreshed auth token with stored credentials")
            responseBlock(error, true, ["Authorization":"Bearer \(self.authToken!.value!)"])
          } else {
            print("F4UserManager: Failed to refresh auth token with stored credentials")
            responseBlock(error, false, ["":""])
          }
        })
      } else {
        print("F4UserManager: No need to refresh token")
        responseBlock(nil, true, ["Authorization":"Bearer \(self.authToken!.value!)"])
      }
    } else {
      responseBlock(nil, true, [:])
    }
  }
}
