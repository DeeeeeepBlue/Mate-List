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
import SwiftUI

import AuthenticationServices
import CryptoKit



let signInConfig = GIDConfiguration.init(clientID: "14102016647-cle326t7m6o3u9n4pdoj5hesasjj5uio.apps.googleusercontent.com")


var Fullname=""
var Email=""
var D_Post_id: [String] = []
fileprivate var currentNonce: String?

class MyPage: UIViewController{

    

    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var btnout: UIButton!
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var LogoutButton: UIButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var loginProviderStackView: UIStackView!

    var fullname_V = ""
    var email_V = ""
    let db = Firestore.firestore()
    var Member_email : [String]=[]
    var dataloading = false
    func DataLoad() {
        
        
        self.db.collection("User").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.Member_email.removeAll()
                    //querySnapshot!.documents : Array -> 딕셔너리 타입임 data() 함수 사용시 내용 확인 가능
                    //ex) let value = querySnapshot!.documents[0].data()
                    //    value["callSelect", default: 0]
                    for document in querySnapshot!.documents {
                        //print(document.data())
                        let value = document.data()

                        let uid_db = value["email"] as? String ?? ""
                        self.Member_email.append(uid_db)
                    }
                   
                }

            //리로드
            self.dataloading=true
            }
        
       }
    func modal_signIn(){
        print("#로그인시쟉")
        self.db.collection("User").document(Auth.auth().currentUser!.uid).setData([
            "user" : Fullname,
            "email" : Email,
            "gender" : true,
            "uid" : Auth.auth().currentUser!.uid
                              ])
        print("#\(self.nameLabel.text)")
        self.nameLabel!.text = fullname_V
        self.emailLabel!.text = email_V
        self.logoutButtonActive()
        btnout.isHidden=false
        self.loginProviderStackView.isHidden = true
        new_mem_agree==0
    }
    //회원탈퇴
    @IBAction func opt_out_request(_ sender: Any) {
        //Habit check 삭제
        db.collection("User").document(Auth.auth().currentUser!.uid).collection("HabitCheck").getDocuments() {(querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.db.collection("User").document(Auth.auth().currentUser!.uid).collection("HabitCheck").document(document.documentID).delete() { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                print("Document successfully removed!")
                            }
                        }
                    }
                }
            //Scrap 삭제
            self.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").getDocuments() {(querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").document(document.documentID).delete() { err in
                                if let err = err {
                                    print("Error removing document: \(err)")
                                } else {
                                    print("Document successfully removed!")
                                }
                            }
                        }
                    }
              
//              ===============
                
                // USER 삭제
                self.db.collection("User").document(Auth.auth().currentUser!.uid).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
    //              ===============
                    //User가 작성한 글 삭제
                self.db.collection("Post").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() {(querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    print("\(document.documentID) => \(document.data())")
                                    D_Post_id.append(document.documentID)
                                }
                            }
                        for document_id in D_Post_id {
                            self.db.collection("Post").document(document_id).delete() { err in
                                if let err = err {
                                    print("Error removing document: \(err)")
                                } else {
                                    print("Document successfully removed!")
                                }
                            }
                        }
                        let alert = UIAlertController(title: "탈퇴", message: "탈퇴완료!", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
                        }
                        alert.addAction(okAction)
                        
                        self.present(alert, animated: true, completion: nil)
                        self.modal_signOUt()
                        new_mem_agree=0
                            
                    }
                    
                    
                    
                    
    //              ===============
                
                
//              ===============
                
                
            }

                
                
                
            }
            
     
            
        }
        
    }
    
    
    
    @IBAction func signIn(sender: Any) {
        if(dataloading){
            print("####",Member_email.count)
            print("####",dataloading)
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                guard error == nil else { return }
                guard let user = user else { return }
                
                AppDelegate.user = user
                print("#AppDelegate.user : \(user.profile!.email)")
                self.fullname_V = user.profile!.email
                self.email_V = user.profile!.name
                let emailAddress = user.profile?.email
                let fullName = user.profile?.name
              
                Fullname = fullName!
                Email = emailAddress!
                
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
                            var flag: Bool = true
                            self.db.collection("BlackList").whereField(Auth.auth().currentUser!.uid, isEqualTo: true).getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    print("@@Error getting documents: \(err)")
                                } else {
                                    for document in querySnapshot!.documents {
                                        // 알럴트로 사용자에게 알리기
                                        self.blackAlert()
                                        // 로그아웃 하기
                                        self.signOut(self)
                                    }
                                    flag = false
                                }

                            }
                            print("User is signed with Firebase&Google")
                            // 로그인 버튼 숨기고 로그아웃 버튼 만들기
                            let gnumaile = "gnu.ac.kr"
                            //firebase User collection에 현재 로그인하는 아이디가 존재하는 지 확인
                            if flag {
                                // gnu 메일인지 확인
                                if emailAddress!.contains(gnumaile){
                                    //이미 회원가입한 멤버가 아닌지 확인
                                    if(!self.Member_email.contains(emailAddress!) && new_mem_agree != 1){
                                        print("####alert실행");
                                        let storyboard = UIStoryboard(name: "consent_popup", bundle: nil)

                                        //컨트롤러 객체 생성, Storyboard ID에 이름 설정(이동할 VC에 설정한 Storyboard ID)
                                        let secondVC: consent_popup = storyboard.instantiateViewController(withIdentifier: "consent_popup") as! consent_popup
                                        new_mem_agree=2
                                        //기본값이 fullScreen이므로 해당 라인은 생략 가능
                                        secondVC.modalPresentationStyle = .fullScreen
                                        self.present(secondVC, animated: true, completion: nil)
        //                                let popup = consent_popup()
        //                                self.present(popup, animated: false, completion: nil)
        //                                popup.modalPresentationStyle = .fullScreen
                                    }else{ // 기존 가입된 계정이면 파이어베이스에 등록
                                        print("######else")
                                        self.db.collection("User").document(Auth.auth().currentUser!.uid).setData([
                                                                "user" : fullName!,
                                                                "email" : emailAddress!,
                                                                "gender" : true,
                                                                "uid" : Auth.auth().currentUser!.uid
                                                              ])
                                        self.nameLabel.text = fullName
                                        self.emailLabel.text = emailAddress
                                        self.logoutButtonActive()
                                        self.btnout.isHidden=false
                                        self.loginProviderStackView.isHidden = true
                                        
                                    }
                                } else {
                                    //gnu 메일이 아니면 회원탈퇴 및 로그아웃
                                    self.db.collection("User").document(Auth.auth().currentUser!.uid).delete() { err in
                                        if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                            print("Document successfully removed!")
                                            
                                            self.modal_signOUt()
                                            let alert = UIAlertController(title: "경상대 학생이 아님", message: "gnu 메일로 로그인해 주세요 !!", preferredStyle: UIAlertController.Style.alert)
                                            let okAction = UIAlertAction(title: "OK", style: .default) {_ in
                                            }
                                            alert.addAction(okAction)
                                            
                                            self.present(alert, animated: true, completion: nil)
                                        }

                                }
                                    
                                }
                                
                            }
                        }
                           
                    }
                }
            }
        }

    }
    
    func modal_signOUt(){
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
        new_mem_agree=0
        btnout.isHidden=true
        self.loginProviderStackView.isHidden = false
        self.viewDidLoad()
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
        btnout.isHidden=true
        self.loginProviderStackView.isHidden = false
        new_mem_agree=0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataLoad()
        loginButtonActive()
        cornerRadius()
        
//        setupProviderLoginView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        DataLoad()
        if(AppDelegate.user == nil){
            btnout.isHidden=true
        }else {btnout.isHidden=false}
        if(new_mem_agree==1){
            print("new_mem_agree true: \(new_mem_agree)")
            modal_signIn()
        }else if(new_mem_agree==2){
            modal_signOUt()
        }

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
        loginProviderStackView.isHidden = true
        NSLayoutConstraint(item: LogoutButton,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: surveyButton,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 20).isActive = true
    }
    
    func loginButtonActive(){
        LogoutButton.layer.isHidden = true
        signInButton.layer.isHidden = false
        loginProviderStackView.isHidden = false
        //로그인 provider 위치 조정
        NSLayoutConstraint(item: loginProviderStackView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: surveyButton,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 20).isActive = true
    }
    
    func cornerRadius(){
        surveyButton.layer.cornerRadius = 20
        surveyButton.layer.borderWidth = 0.5
        surveyButton.layer.borderColor = UIColor(rgb:0xE5E5E5).cgColor
        
        LogoutButton.layer.cornerRadius = 20
        LogoutButton.layer.borderWidth = 0.5
        LogoutButton.layer.borderColor = UIColor(rgb:0xE5E5E5).cgColor
        
        accountView.layer.cornerRadius = 20
        accountView.layer.borderWidth = 0.5
        accountView.layer.borderColor = UIColor(rgb:0xE5E5E5).cgColor
        
    }
    
    // MARK: - Apple login
    

    
    ///로그인 버튼 생성
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    ///로그인 실행..???
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
//    func performExistingAccountSetupFlows() {
//        // Prepare requests for both Apple ID and password providers.
//        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
//                        ASAuthorizationPasswordProvider().createRequest()]
//
//        // Create an authorization controller with the given requests.
//        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
    
}

extension MyPage: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension MyPage: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // firbase apple authentication
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
              guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
              }
              guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
              }
              guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
              }
              // Initialize a Firebase credential.
              let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                        idToken: idTokenString,
                                                        rawNonce: nonce)
              // Sign in with Firebase.
              Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                      print("Firebase sign in error: \(error)")
                      return
                      
                  } else {
                      print("User is signed with Firebase&Google")
                      // 로그인 버튼 숨기고 로그아웃 버튼 만들기
                      self.db.collection("User").document(Auth.auth().currentUser!.uid).setData([
                                              "user" : fullName!,
                                              "email" : email!,
                                              "gender" : true,
                                              "uid" : Auth.auth().currentUser!.uid
                                            ])
                      self.logoutButtonActive()
                }
                // User is signed in to Firebase with Apple.
                  self.loginProviderStackView.isHidden = true
              }
            }
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        
        case let passwordCredential as ASPasswordCredential:

            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password

            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
//                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        guard let viewController = self.presentingViewController as? MyPage
            else { return }
        
        DispatchQueue.main.async {
            viewController.nameLabel.text = userIdentifier
            if let email = email {
                viewController.emailLabel.text = email
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    /// 🔥 firebase hasing function
    /// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

