
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

var Fullname=""
var Email=""

class MyPage: UIViewController {
    
    @IBOutlet weak var surveyButton: UIButton!
    @IBOutlet weak var LogoutButton: UIButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    var fullname_V = ""
    var email_V = ""
    let db = Firestore.firestore()
    var Member_email : [String]=[]
    var dataloading = false
    func DataLoad() {
        Member_email.removeAll()
        
        self.db.collection("User").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
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
                            print("User is signed with Firebase&Google")
                            // 로그인 버튼 숨기고 로그아웃 버튼 만들기
                            
                            //firebase User collection에 현재 로그인하는 아이디가 존재하는 지 확인
//
                            if(!self.Member_email.contains(emailAddress!)){
                                print("####alert실행");
                            }else{ // 기존 가입된 계정이면 파이어베이스에 등록
                                self.db.collection("User").document(Auth.auth().currentUser!.uid).setData([
                                                        "user" : fullName!,
                                                        "email" : emailAddress!,
                                                        "gender" : true,
                                                        "uid" : Auth.auth().currentUser!.uid
                                                      ])
                                self.nameLabel.text = fullName
                                self.emailLabel.text = emailAddress
                                self.logoutButtonActive()
                            }
                            
                            
                        }
                    }
                }
            }
        }else{
            
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
        DataLoad()
        loginButtonActive()
        cornerRadius()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        DataLoad()
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
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
