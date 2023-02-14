//
//  AppDelegate.swift
//  checkMate
//
//  Created by 한상윤 on 2022/01/29.
//

import UIKit

import GoogleSignIn
import Firebase
import AuthenticationServices
import FirebaseCore
import FirebaseFirestore
import RxSwift

import Core
import Utility


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //public static var user: GIDGoogleUser!
    public static var userAuth = BehaviorSubject<AuthDataResult?>(value: nil)
    public static var fireAuth = FireAuth()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Use Firebase library to configure APIs
        // Firebase 연결
        FirebaseApp.configure()
        
        
        AppDelegate.fireAuth.signOut()
        
        print("app")
        return true
    }

    // MARK: Google Login
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            
            // 세로방향 고정
            return UIInterfaceOrientationMask.portrait
        }
}

