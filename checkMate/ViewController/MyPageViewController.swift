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

import AuthenticationServices
import CryptoKit



let signInConfig = GIDConfiguration.init(clientID: "14102016647-cle326t7m6o3u9n4pdoj5hesasjj5uio.apps.googleusercontent.com")

fileprivate var currentNonce: String?

class MyPage: UIViewController{
    
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
        
        setupProviderLoginView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {

//        performExistingAccountSetupFlows()
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
        
    }
    
    // MARK: - Apple login
    
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
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
                  if (error != nil) {
                  // Error. If error.code == .MissingOrInvalidNonce, make sure
                  // you're sending the SHA256-hashed nonce as a hex string with
                  // your request to Apple.
                      print(error?.localizedDescription)
                  return
                }
                // User is signed in to Firebase with Apple.
                // ...
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
