//
//  MyPage.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/04.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore
import Firebase


let signInConfig = GIDConfiguration.init(clientID: "14102016647-cle326t7m6o3u9n4pdoj5hesasjj5uio.apps.googleusercontent.com")

class MyPage: UIViewController {
    
    @IBOutlet weak var LogoutButton: UIButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var appView: UIView!
    @IBOutlet weak var developeView: UIView!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signInButtonConstant: NSLayoutConstraint!
    
    var db: Firestore!
    
    @IBAction func signIn(sender: Any) {
      
      GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
          guard error == nil else { return }
          guard let user = user else { return }
          
          AppDelegate.user = user
          
          let emailAddress = user.profile?.email
          let fullName = user.profile?.name
          self.nameLabel.text = fullName
          self.emailLabel.text = emailAddress
          
          
          user.authentication.do { authentication, error in
              guard error == nil else { return }
              
              guard let authentication = authentication,
                  let idToken = authentication.idToken else { return }
          
              // Send ID token to backend (example below).
              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
              
              Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                      print("Firebase sign in error: \(error)")
                      return
                      
                  } else {
                      print("User is signed with Firebase&Google")
                      // 로그인 버튼 숨기고 로그아웃 버튼 만들기
                      self.db.collection("User").document(Auth.auth().currentUser!.uid).setData([
                                              "user" : fullName!,
                                              "email" : emailAddress!,
                                              "gender" : true,
                                              "uid" : Auth.auth().currentUser!.uid
                                            ])
                      self.logoutButtonActive()
                      
                  }
                  
              }

              
          }
          
      }
        
        
        
    }
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
             do {
               try firebaseAuth.signOut()
                 loginButtonActive()
                 GIDSignIn.sharedInstance.disconnect{ error in
                     guard error == nil else { return }
                     AppDelegate.user = nil
                 }
                 self.nameLabel.text = "로그인이 필요합니다."
                 self.emailLabel.text = "로그인이 필요합니다."
                 
             } catch let signOutError as NSError {
               print("Error signing out: %@", signOutError)
             }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonActive()
        cornerRadius()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func logoutButtonActive(){
        signInButton.layer.isHidden = true
//        signInButtonConstant.constant = 0
        LogoutButton.layer.isHidden = false
    }
    
    func loginButtonActive(){
        LogoutButton.layer.isHidden = true
//        signInButtonConstant.constant = 120
        signInButton.layer.isHidden = false
    }
    
    func cornerRadius(){
        accountView.layer.cornerRadius = 5
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
