//
//  MyPage.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/04.
//

import UIKit

import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore
import Firebase
import AuthenticationServices
import CryptoKit


var flag: Bool = true
let signInConfig =  AppDelegate.authFunc.signInConfig
var name=""
var email=""
var D_Post_id: [String] = []
fileprivate var currentNonce: String?

class Info: UIViewController{
    //MARK: - Properties
    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var btnout: UIButton!
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var LogoutButton: UIButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    var Member_email : [String]=[]
    var dataloading = false
    
    //MARK: - IBAction
    /// 회원탈퇴
    @IBAction func opt_out_request(_ sender: Any) {
        let uid = Auth.auth().currentUser!.uid
        //Scrap 삭제
        deleteScrap(uid: uid)
        
        //Habit check 삭제
        deleteHabitCheck(uid: uid)
        
        //User가 작성한 글 삭제
        deletePage(uid: uid)
        
        // USER 삭제
        deleteUser(uid: uid)
        
        // App Delegate 로그아웃
        modal_signOut()
        
        let alert = UIAlertController(title: "탈퇴", message: "탈퇴완료!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    /// 로그인
    @IBAction func googleSignIn(sender: Any) {
        if (dataloading){
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                guard error == nil else { return }
                guard let user = user else { return }
                
               
                email = user.profile!.email
                name = user.profile!.name
                
                user.authentication.do { authentication, error in
                    guard error == nil else { return }
                    
                    guard let authentication = authentication,
                          let idToken = authentication.idToken else { return }
                    
                    // Send ID token to backend (example below).
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                   accessToken: authentication.accessToken)
                    
                    self.authSignIn(credential: credential)
                }
            }
        }
        
    }
    
    /// 로그아웃
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            loginButtonActive()
            GIDSignIn.sharedInstance.disconnect{ error in
                guard error == nil else { return }
                AppDelegate.userAuth = nil
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
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataLoad()
        loginButtonActive()
        cornerRadius()
        setupProviderLoginView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DataLoad()
        if(AppDelegate.userAuth == nil){
            btnout.isHidden=true
        }
        else {
            btnout.isHidden=false
        }
        if(new_mem_agree==1){
            modal_signIn()
        }else if(new_mem_agree==2){
            modal_signOut()
        }
        
    }
    
    //MARK: - Sign In
    /// 공통 auth 로그인
    func authSignIn(credential : AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase sign in error: \(error)")
                return
            } else {
                AppDelegate.userAuth = authResult
                self.checkBlack()
                self.checkSchool(emailAddress: email, name: name)
            }
        }
    }
    
    /// 블랙리스트 체크
    func checkBlack() {
        FireStoreService.db.collection("BlackList").whereField(Auth.auth().currentUser!.uid, isEqualTo: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("@@Error getting documents: \(err)")
            } else {
                for _ in querySnapshot!.documents {
                    // 알럴트로 사용자에게 알리기
                    self.blackAlert()
                    // 로그아웃 하기
                    self.signOut(self)
                }
            }
        }
    }
    
    /// 경상대 확인 함수
    func checkSchool( emailAddress : String, name : String) {
        // gnu 메일인지 확인
        if emailAddress.contains(gnumaile){
            //이미 회원가입한 멤버가 아닌지 확인
            if(!self.Member_email.contains(emailAddress) && new_mem_agree != 1){
                agreeCheck()
            }else{
                // 기존 가입된 계정이면 파이어베이스에 등록
                self.registUserFirebase(user: name, email: emailAddress)
            }
        } else {
            //gnu 메일이 아니면 회원탈퇴 및 로그아웃
            self.schoolAlert()
            self.deleteUser(uid: Auth.auth().currentUser?.uid ?? "")
            self.modal_signOut()
        }
    }
    /// 학생 아님 경고창
    func schoolAlert(){
        let alert = UIAlertController(title: "경상대 학생이 아님", message: "gnu 메일로 로그인해 주세요 !!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /// 개인정보 제공 동의서 제출
    func agreeCheck(){
        let storyboard = UIStoryboard(name: "consent_popup", bundle: nil)
        //컨트롤러 객체 생성, Storyboard ID에 이름 설정(이동할 VC에 설정한 Storyboard ID)
        let secondVC: consent_popup = storyboard.instantiateViewController(withIdentifier: "consent_popup") as! consent_popup
        new_mem_agree=2
        //기본값이 fullScreen이므로 해당 라인은 생략 가능
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true, completion: nil)
    }
    
    
    /// 파이어베이스에 등록하기
    func registUserFirebase(user : String, email : String) {
        FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).setData([
            "user" : user,
            "email" : email,
            "gender" : true,
            "uid" : Auth.auth().currentUser!.uid
        ])
        nameLabel.text = user
        emailLabel.text = email
        logoutButtonActive()
        btnout.isHidden=false
        loginProviderStackView.isHidden = true
    }
    
    /// 로그인
    func modal_signIn(){
        FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).setData([
            "user" : name,
            "email" : email,
            "gender" : true,
            "uid" : Auth.auth().currentUser!.uid
        ])
        
        self.nameLabel!.text = name
        self.emailLabel!.text = email
        logoutButtonActive()
        btnout.isHidden=false
        self.loginProviderStackView.isHidden = true
    }
    //MARK: - Sign Out
    /// user 게시글 삭제
    func deletePage(uid : String){
        FireStoreService.db.collection("Post").whereField("uid", isEqualTo: uid).getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    D_Post_id.append(document.documentID)
                }
            }
            for document_id in D_Post_id {
                FireStoreService.db.collection("Post").document(document_id).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }
            
        }
    }
    
    /// Scrap 삭제
    func deleteScrap(uid : String){
        FireStoreService.db.collection("User").document(uid).collection("Scrap").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    FireStoreService.db.collection("User").document(uid).collection("Scrap").document(document.documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
            }
        }
    }
    
    /// User HabitCheck 삭제
    func deleteHabitCheck(uid : String){
        FireStoreService.db.collection("User").document(uid).collection("HabitCheck").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    FireStoreService.db.collection("User").document(uid).collection("HabitCheck").document(document.documentID).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
            }
        }
    }
    
    
    /// User 삭제
    func deleteUser(uid : String) {
        FireStoreService.db.collection("User").document(uid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    

    
    /// 로그아웃
    func modal_signOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            loginButtonActive()
            GIDSignIn.sharedInstance.disconnect{ error in
                guard error == nil else { return }
                AppDelegate.userAuth = nil
            }
            nameLabel.text = "로그인이 필요합니다."
            emailLabel.text = "로그인이 필요합니다."
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        new_mem_agree=0
        btnout.isHidden=true
        self.loginProviderStackView.isHidden = false
        
    }
    
    
    //MARK: - Data Load
    /// 데이터 로드
    func DataLoad() {
        FireStoreService.db.collection("User").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.Member_email.removeAll()
                //querySnapshot!.documents : Array -> 딕셔너리 타입임 data() 함수 사용시 내용 확인 가능
                //ex) let value = querySnapshot!.documents[0].data()
                //    value["callSelect", default: 0]
                for document in querySnapshot!.documents {
                    let value = document.data()
                    
                    let uid_db = value["email"] as? String ?? ""
                    self.Member_email.append(uid_db)
                }
                
            }
            
            self.dataloading=true
        }
        
    }
    
    
    //MARK: - UI Set
    /// 블랙 리스트 alert
    func blackAlert() {
        let alert = UIAlertController(title: "블랙 리스트", message: "해당 사용자는 타 사용자의 신고로 인해 블랙리스트에 추가되었습니다. 이의가 있으시면 문의하기로 연락 부탁드립니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    /// 로그인 버튼 활성화
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
    
    /// 로그인 버튼 비활성화
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
    
    /// 버튼 모서리 세팅
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
    
    /// 이름, 이메일 UI 변경
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        guard let viewController = self.presentingViewController as? Info
        else { return }
        
        DispatchQueue.main.async {
            viewController.nameLabel.text = userIdentifier
            if let email = email {
                viewController.emailLabel.text = email
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    ///Apple 로그인 버튼 생성
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    
    
    ///로그인 함수
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        startSignInWithAppleFlow()
    }
    
    
}

// MARK: - Apple login
extension Info: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension Info: ASAuthorizationControllerDelegate {
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
            authSignIn(credential: credential)
            
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
