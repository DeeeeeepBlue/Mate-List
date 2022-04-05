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
    
    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var LogoutButton: UIButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
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
                  
                  // 블랙 리스트 유저 체크
                  self.db.collection("BlackList").whereField(Auth.auth().currentUser!.uid, isEqualTo: true).getDocuments() { (querySnapshot, err) in
                      if let err = err {
                          print("@@Error getting documents: \(err)")
                      } else {
                          for document in querySnapshot!.documents {
                              // 알럴트로 사용자에게 알리기
                              self.blackAlert()
                              // 로그아웃 하기
                              self.signOut(self)
                              print("@@\(document.documentID) => \(document.data())")
                          }
                      }
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
    
    func blackAlert() {
        let alert = UIAlertController(title: "블랙 리스트", message: "해당 사용자는 타 사용자의 신고로 인해 블랙리스트에 추가되었습니다. 이의가 있으시면 문의하기로 연락 부탁드립니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func logoutButtonActive(){
        signInButton.layer.isHidden = true
        LogoutButton.layer.isHidden = false
    }
    
    func loginButtonActive(){
        LogoutButton.layer.isHidden = true
        signInButton.layer.isHidden = false
    }
    
    func cornerRadius(){
        surveyButton.layer.cornerRadius = 20
        surveyButton.layer.borderWidth = 0.5
        surveyButton.layer.borderColor = UIColor.gray.cgColor
        
        LogoutButton.layer.cornerRadius = 20
        LogoutButton.layer.borderWidth = 0.5
        LogoutButton.layer.borderColor = UIColor.gray.cgColor
        
        accountView.layer.cornerRadius = 20
        accountView.layer.borderWidth = 0.5
        accountView.layer.borderColor = UIColor.gray.cgColor
        
        inquiryButton.layer.cornerRadius = 20
        inquiryButton.layer.borderWidth = 0.5
        inquiryButton.layer.borderColor = UIColor.gray.cgColor
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
