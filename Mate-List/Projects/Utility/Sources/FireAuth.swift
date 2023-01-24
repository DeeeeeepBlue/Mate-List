//
//  Auth.swift
//  checkMate
//
//  Created by 강민규 on 2022/10/08.
//

import Foundation

import FirebaseAuth
import AuthenticationServices
import GoogleSignIn

public struct FireAuth {
    public init() {}
    
    let signInConfig =  GIDConfiguration.init(clientID: "14102016647-37m019d8iopsi0i7utjfpqas4h4l3ebe.apps.googleusercontent.com")
    
    public func signOut(){
        let firebaseAuth = Auth.auth()
      do {
        try firebaseAuth.signOut()
      } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
      }
    }
    
    
    
}
