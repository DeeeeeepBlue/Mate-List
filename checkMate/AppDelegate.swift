//
//  AppDelegate.swift
//  checkMate
//
//  Created by 한상윤 on 2022/01/29.
//

import GoogleSignIn
import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public static var user: GIDGoogleUser!
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Use Firebase library to configure APIs
        // Firebase 연결
        FirebaseApp.configure()
    
        signOut()
        return true
    }
    
    func signOut(){
        let firebaseAuth = Auth.auth()
      do {
        try firebaseAuth.signOut()
      } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
      }
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

