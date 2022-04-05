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
                                let alert = UIAlertController(title: "아래 항목에 동의하십니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
//                                var agreetextField: UITextField?
                                // Add textfield to alert view
                                let agreeText = """
커뮤니티 이용규칙 안내 \n
Mate-List는 깨끗한 커뮤니티를 만들기 위해 이용규칙을 제정하여 운영하고 있습니다. 모든 이용자는 글 등록하는 동시에 아래 이용규칙에 동의하였음으로 간주합니다. 모든 이용자는 커뮤니티 이용 전 반드시 커뮤니티 이용규칙의 모든 내용을 숙지하여야 합니다.\n
모든 이용자는 방송통신심의위원회의 정보통신에 관한 심의규정,현행 법률,서비스 이용 약관 및 커뮤니티 이용규칙을 위반하거나, 사회 통념 및 관련 법령을 기준으로 타 이용자에게 악영향을 끼치는 경우, 게시물이 삭제되고 서비스 이용이 제한될 수 있습니다.\t
커뮤니티 이용규칙은 불법 행위, 각종 차별 및 혐오, 사회적 갈등 조장,타인의 권리 침해, 다른 이용자에게 불쾌감을 주는 행위, 커뮤니티 유출 행위, 시스템 장애를 유발하는 비정상 행위 등 커뮤니티 분위기 형성과 운영에 악영향을 미치는 행위들을 제한하기 위해 지속적으로 개정됩니다.\t
커뮤니티 이용자에게 다음과 같은 행위를 금지합니다.\t
1. 범죄 기타 법령에 위반되는 행위 \t
- 범죄를 목적으로 하여 범죄 수단이나 방법 또는 범죄에 이르는 과정이나 결과를 구체적으로 묘사하는 행위\t
- 범죄, 범죄인, 범죄 단체를 미화하는 행위\t
- 그 밖에 범죄 및 법령에 위반되는 위법행위를 조장하여 건전한 법질서를 현저히 해할 우려가 있는 행위 \t
2. 사회통념상 일반인의 성욕을 자극하여 성적 흥분을 유발하고 정상적인 성적 수치심을 해하여 도의관념에 반하는 행위 \t
- 신체 부위 또는 성적 행위를 노골적으로 표현, 묘사하는 행위 \t
- 유흥 관련 정보 공유, 매매·알선 행위 등 불법 행위 \t
- 그 밖에 일반인의 성적 수치심을 현저히 해할 우려가 있는 행위 \t
 3. 폭력성, 잔혹성, 혐오성 등이 심각한 행위 \t
 - 살상, 폭행, 협박, 학대행위들을 지나치게 상세히 표현하여 혐오감을 불러일으키는 행위 \t
- 과도한 욕설 등 저속한 언어를 사용하여 혐 \t
 4. 사회통합 및 사회질서를 저해하는 행위 \t
 - 도박 등 사행심을 조장하는 행위 \t
 - 사회적인 소외계층을 비하하는 행위 \t
- 자살을 목적으로 하거나 이를 미화, 방조 또는 권유하여 자살 충동을 일으킬 우려가 있는 행위 \t
 - 그 밖에 사회적 혼란을 현저히 야기할 우려가 있는 행위 \t
 5. 타인의 권리를 침해하는 행위 \t
 - 다른 이용자에게 불쾌감이나 불편함을 주는 행위 \t
 - 개인정보 유포 등 사생활의 비밀과 자유를 침해할 우려가 현저한 행위 \t
 - 그 밖에 정당한 권한없이 타인의 권리를 침해하는 행위 \t
 6. 악용 행위 \t
 - 익명을 이용한 여론 조작 행위 \t
 - 신고 제도를 악용하는 행위 \t
 - 운영자 또는 이에 준하는 자격을 사칭하여 권한을 행사하는 행위 \t
 - 외부 서비스 이용을 강제하거나 유도하는 행위 \t
허위사실 유포 및 명예훼손 게시물에 대한 게시중단 요청 \t
 1. 모든 게시물은 커뮤니티 운영 시스템에 의해 처리됩니다. \t
 2. 게시물로 인해, 저작권 침해, 명예훼손, 기타 권리 침해를 당했다고 판단되실 경우, 추가적인 권리 침해를 방지하기 위해 개발자 메일(deeeeeep0122@gmail.com)로 해당 게시물에 대한 게시 중단 요청을 할 수 있습니다. \t
 3. 이후 담당자의 확인을 통해 게시 중단 조치가 이루어지며, 게시 중단 사유가 공개됩니다.
"""

                                var agreeTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                                print("#agreeText : \(agreeText)")
                                agreeTextLabel.text = agreeText
                                alert.view.addSubview(agreeTextLabel)
                                
                                //                                alert.addTextField { (agreetextField) in
//                                    agreetextField.text = self.agreeText
//                                  agreetextField.addConstraint(agreetextField.heightAnchor.constraint(equalToConstant: 400))
//                                    agreetextField.layer.borderWidth=0
//                                    agreetextField.layer.backgroundColor = UIColor.clear.cgColor
//                                    agreetextField.isUserInteractionEnabled = false
//
//                                }
                                let okAction = UIAlertAction(title: "OK", style: .default) {_ in
                                }
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
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

