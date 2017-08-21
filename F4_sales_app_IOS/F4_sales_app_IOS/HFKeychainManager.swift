//
//  F4TokenModel.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 15/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import Foundation

class HFKeychainManager {
  
  let aKeychainWrapper = KeychainWrapper()
  let userDefaults = UserDefaults.standard
  
  struct KeychainConstants {
    static let UserDefaultsHasCredentialsKey  = "hasLoginKey"
    static let UserDefaultsUsernameKey        = "username"
    
    static let KeychainSecuredDataKey         = "v_Data"
  }
  
  
  // MARK: Class functions
  
  func credentialsStored() -> Bool {
    return userDefaults.bool(forKey: KeychainConstants.UserDefaultsHasCredentialsKey)
  }
  
  func storeCredentials(username: String, password: String) {
    if credentialsStored() == false {
      userDefaults.setValue(username, forKey: KeychainConstants.UserDefaultsUsernameKey)
    }
    
    aKeychainWrapper.mySetObject(password, forKey: kSecValueData)
    aKeychainWrapper.writeToKeychain()
    userDefaults.set(true, forKey: KeychainConstants.UserDefaultsHasCredentialsKey)
    userDefaults.synchronize()
    
    print("KeychainManager: Credentials successfully stored")
  }
  
  func updatePassword(newPassword: String) {
    aKeychainWrapper.mySetObject(newPassword, forKey: kSecValueData)
    aKeychainWrapper.writeToKeychain()
    print("KeychainManager: Password successfully updated")
  }
  
  func updateUsername(newUsername: String) {
    userDefaults.setValue(newUsername, forKey: KeychainConstants.UserDefaultsUsernameKey)
    userDefaults.synchronize()
    
    print("KeychainManager: Username successfully updated")
  }
  
  func clearStoredCredentials() {
    if credentialsStored() {
      userDefaults.setValue(false, forKey: KeychainConstants.UserDefaultsHasCredentialsKey)
      userDefaults.removeObject(forKey: KeychainConstants.UserDefaultsUsernameKey)
      aKeychainWrapper.mySetObject("", forKey: kSecValueData)
      aKeychainWrapper.writeToKeychain()
      userDefaults.synchronize()
    }
  }
  
  func retrieveStoredCredentials() -> (username: String, password: String, success: Bool) {
    if let password: String = aKeychainWrapper.myObject(forKey: KeychainConstants.KeychainSecuredDataKey) as? String {
      if let username: String = UserDefaults.standard.value(forKey: KeychainConstants.UserDefaultsUsernameKey) as? String {
        return (username, password, true)
      }
    }
    return ("", "", false)
  }
  
  func attemptAutoSignIn(responseBlock: @escaping (_ success: Bool) -> Void) {
    if credentialsStored() {
      let storedCredentialResult = retrieveStoredCredentials()
      if storedCredentialResult.success {
        F4UserManager.shared.signIn(withUsername: storedCredentialResult.username, andPassword: storedCredentialResult.password, responseBlock: { (error, success) in
          if error == nil && success {
            print("KeychainManager: Auto login was successful!")
            responseBlock(true)
          } else {
            print("KeychainManager: Auto login was unsuccessful!")
            responseBlock(false)
          }
        })
      }
    } else {
      print("KeychainManager: No credentials are stored")
      responseBlock(false)
    }
  }
  
}
