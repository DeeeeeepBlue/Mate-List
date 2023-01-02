//
//  SettingViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit
import AuthenticationServices
import CryptoKit
import FirebaseAuth

import SnapKit
import RxSwift
import RxCocoa
import GoogleSignIn

class SettingViewController: BaseViewController {
    //MARK: - Properties
    private let repository = SettingRepository()
    
    private let myProfileView = MyProfileView()
    private let surveyButton = SurveyButton()
    private let questionButton = QuestionButton()
    private let signOutButton = SignOutButton()
    private let quitButton = QuitButton()
    private let signInButtonView = SignInButtonView()
    
    private let nickNameView = NickNameView()
    
    fileprivate var currentNonce: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func style() {
        super.style()
        
        navigationController?.title = "내 정보"
        
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    override func setView() {
        self.view.addSubview(myProfileView)
        self.view.addSubview(signInButtonView)
        self.view.addSubview(surveyButton)
        self.view.addSubview(questionButton)
        self.view.addSubview(signOutButton)
        self.view.addSubview(quitButton)
        
    }
    
    override func setConstraint() {
        myProfileView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
        
        surveyButton.snp.makeConstraints { make in
            make.top.equalTo(myProfileView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        signInButtonView.snp.makeConstraints { make in
            make.top.equalTo(surveyButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(120)
        }
        
        questionButton.snp.makeConstraints { make in
            make.top.equalTo(signInButtonView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.top.equalTo(questionButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        quitButton.snp.makeConstraints { make in
            make.top.equalTo(signOutButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
    }
    
    override func setBind() {
        
        signInButtonView.authorizationButton.rx
            .controlEvent(.touchUpInside)
            .bind {
                self.startSignInWithAppleFlow()
            }
        
        signInButtonView.googleButton.rx
            .controlEvent(.touchUpInside)
            .bind {
                self.startSignInWithGoogleFlow()
            }
    }

}

//MARK: - Apple SignIn

extension SettingViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


extension SettingViewController: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
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
            repository.authSignIn(credential: credential)
            
            // User is signed in to Firebase with Apple.
            // ...
        }
    }
    
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
    
    /// 🔥 firebase hasing function
    /// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    func randomNonceString(length: Int = 32) -> String {
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
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
        
    }
}

// MARK: - Google Sign In
extension SettingViewController {
    func startSignInWithGoogleFlow() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }

            signInResult.user.refreshTokensIfNeeded { user, error in
                guard error == nil else { return }
                guard let user = user else { return }

                guard let idToken = user.idToken else { return }
                // Send ID token to backend (example below).
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: user.accessToken.tokenString)
                
                self.repository.authSignIn(credential: credential)
            }
        }
    }
}
