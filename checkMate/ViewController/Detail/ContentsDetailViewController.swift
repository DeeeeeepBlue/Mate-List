//
//  ContentsDetailViewController.swift
//  checkMate
//
//  Created by 한상윤 on 2022/02/17.
//

import UIKit
import MessageUI

import Firebase
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth
import gRPC_Core



class ContentsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, MFMailComposeViewControllerDelegate {
    //MARK: - Properties
    var send_username : String!
    
    @IBOutlet weak var replyTableView: UITableView!
    @IBOutlet weak var contentsTextView: UITextView!
    
    @IBOutlet weak var replyTextField: UITextField!
    @IBOutlet weak var replyOkButton: UIButton!
    
    @IBOutlet weak var contentDeleteButton: UIButton!
    @IBOutlet weak var writerPatternButton: UIButton!
    
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var replyTextFieldStackView: UIStackView!
    
    var replyTableViewController = UITableViewController()
    
    let color = UIColor.mainGrey
    
    var lef: DatabaseReference!
    var List : [Post] = []
    var replyList: [reply] = []
    var scrapFlag = false
    var check_replyuser : [Bool] = []
    var viewHeight : CGFloat = 0
    var ref: DocumentReference? = nil
    var contentsDetailData: Post!
    
    //MARK: - IBAction
    @IBAction func ScrapButton(_ sender: Any) {
        guard Auth.auth().currentUser != nil else {
            haveUesr()
            return
        }
        scrapDataLoad{ [self] (result) in
            
            if result {
                
                contentsDetailData.isScrap = false
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
                FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").document(contentsDetailData.pid).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }else{
                contentsDetailData.isScrap = true
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
                FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").document(contentsDetailData.pid).setData([
                    "contents" : contentsDetailData.contents,
                    "title" :  contentsDetailData.title,
                    "uid" : contentsDetailData.uid,
                    "user" : contentsDetailData.author,
                    "date" : getDate(),
                    "findMate" : false,
                    "isScrap" : contentsDetailData.isScrap
                ])
            }
        }
        
        
        
        
        
    }
    
    @IBAction func goTotresh(_ sender: Any) {
        print("삭제")
        
        FireStoreService.db.collection("Post").document("\(contentsDetailData.pid)").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        FireStoreService.db.collection("Post").document("\(contentsDetailData.pid)").collection("Comment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    FireStoreService.db.collection("Post").document(self.contentsDetailData.pid).collection("Comment").document(document.documentID).delete()
                }
            }
        }
        
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func saveButton(_ sender: Any) {
        let inputText = replyTextField.text
        // 한 글자라도 입력해야 댓글이 달림
        if inputText!.count > 0 && AppDelegate.user != nil {
            
            replyList.removeAll()
            // 유저 이름 분리
            let str = AppDelegate.user.profile!.email as String
            let userName = str.split(separator: "@")
            
            
            
            // Firestore에 데이터 올리는 코드
            // var ref: DocumentReference? = nil
           
            
            if inputText!.count > 30 {
                let alert = UIAlertController(title: "글자 수 초과!", message: "댓글 30자 이내로 작성해 주세요", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .default) {_ in
                }
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
            }else{
                ref = FireStoreService.db.collection("Post").document(contentsDetailData.pid).collection("Comment").addDocument(data: [
                    "reply" : inputText!,
                    "uid" : Auth.auth().currentUser!.uid,
                    "user" : String(userName[0]),
                    "date" : getDate()
                ])
                
                
            }
            
            replyTextField.text?.removeAll()
            DataLoad()
            self.replyTableView.reloadData()
            
            
        }
        if AppDelegate.user == nil {
            haveUesr()
            replyTextField.text?.removeAll()
            self.replyTableView.reloadData()
        }
        
        else {
            replyTextField.text?.removeAll()
            self.replyTableView.reloadData()
        }
    }
    
    /// 댓글 삭제
    @IBAction func replyDelete(_ sender: UIButton) {
        // 버튼의 위치 찾기
        let contentView = sender.superview
        let cell = contentView?.superview as! UITableViewCell
        let indexPath = replyTableView.indexPath(for: cell)
        
        if replyList.count > 0 {
            // 댓글의 문서 id 삭제
            FireStoreService.db.collection("Post").document(contentsDetailData.pid).collection("Comment").document(replyList[indexPath!.section].docid).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }

        
        // 화면 재구성
        replyList.removeAll()
        DataLoad()
        self.replyTableView.reloadData()
        
    }
    
    /// 게시글 신고하기
    @IBAction func reportButton(_ sender: Any) {
        
        // 이메일 사용가능한지 체크하는 if문
        if MFMailComposeViewController.canSendMail() {
            
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self
            
            compseVC.setToRecipients(["deeeeeep0122@gmail.com"])
            compseVC.setSubject("[메이트리스트]게시글 신고")
            compseVC.setMessageBody("\(contentsDetailData.pid)", isHTML: false)
            self.present(compseVC, animated: true, completion: nil)
            
        }
        else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func patternButtonClick(_ sender: Any){
        self.view.endEditing(true)
    }
    
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        DataLoad()
        replyTableView.reloadData()
        habitDataLoad()
        // 게시글 작성자만 삭제 버튼 보이게 하기
        if Auth.auth().currentUser == nil {
            contentDeleteButton.isHidden = true
        } else {
            if Auth.auth().currentUser?.uid != contentsDetailData.uid {
                contentDeleteButton.isHidden = true
                
            }
        }
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //옵저버
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setData()
        setView()
 
    }
    //MARK: - Set Function
    func setData() {
          currentData = contentsDetailData
          userHabitCheck.removeAll()
          
          scrapDataLoad{ (result) in
              print("*클로저 실행\(result)")
              self.scrapFlag = result
              if self.scrapFlag{
                  print("*별색 채우기")
                  self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
              }else{
                  print("*별색 못채우기")
                  self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
              }
          }
          
    }
    
    func setView() {
        viewHeight = self.view.frame.size.height
       
        replyOkButton.layer.borderColor = color.cgColor
        replyOkButton.layer.borderWidth = 1
        replyOkButton.layer.cornerRadius = 10
        replyOkButton.tintColor = .white
        replyTextField.layer.borderWidth = 1
        replyTextField.layer.cornerRadius = 10
        replyTextField.layer.borderColor = color.cgColor
        
        let userLabel = self.view.viewWithTag(1) as! UILabel
        let tittleLabel = self.view.viewWithTag(2) as! UILabel
        let contentsText = self.view.viewWithTag(3) as! UITextView
        let dateLabel = self.view.viewWithTag(4) as! UILabel
        
        replyTableViewController.tableView.delegate = self
        replyTableViewController.tableView.dataSource = self
        replyTableView.delegate = self
        replyTableView.dataSource = self
        

        userLabel.text = contentsDetailData.author
        send_username =  userLabel.text
        userLabel.textAlignment = .right
        userLabel.sizeToFit()
        tittleLabel.text = contentsDetailData.title
        tittleLabel.sizeToFit()
        contentsText.text = contentsDetailData.contents
        contentsText.sizeToFit()
        dateLabel.text = contentsDetailData.date
        dateLabel.sizeToFit()
      
        // 셀 크기 자동조절
        replyTableView.estimatedRowHeight = 60
        replyTableView.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: - Custom Function
    
    func DataLoad()  {
            //데이터 불러오기
        self.replyList.removeAll()
        FireStoreService.db.collection("Post").document(contentsDetailData?.pid ?? "").collection("Comment").order(by: "date").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let value = document.data()
//                    let reg_db = false
                    let author_db = value["user"] as? String ?? ""
                    let content_db = value["reply"] as? String ?? ""
                    let date_db = value["date"] as? String ?? ""
                    let uid_db = value["uid"] as? String ?? ""
//                    let isScrap_db = value["isScrap"] as? Bool ?? false
//                    let findMate = value["findMate"]! as! Bool
        
                    self.replyList.append(reply(author: author_db, contents: content_db, date: date_db, uid: uid_db, docid: document.documentID))
//                    print("\(document.documentID) => \(document.data())")
                    print("## : \(self.replyList)")
                    
                    
                }
                self.replyUserCheck()
            }
            
            self.replyTableView.reloadData()
        }
    }
    
    func replyUserCheck() {
        self.check_replyuser.removeAll()
        for item in replyList {
            if item.uid != Auth.auth().currentUser?.uid {
                self.check_replyuser.append(false)
            }else{self.check_replyuser.append(true)}
        }
    }
    
    func scrapDataLoad(_ escapingHandler : @escaping (Bool) -> ()) {
            //데이터 불러오기
        guard AppDelegate.user != nil else {return }
        var result: Bool = false
        FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").document(contentsDetailData.pid).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let trueScrap: String = "\"isScrap\": 1"
                if dataDescription.contains(trueScrap){
                    result = true
                    print("*이스케이프 실행 전 \(result)")
                    escapingHandler(result)
                    print("*이스케이프 실행 후 \(result)")
                }
                else
                {
                    result = false
                }
                
            }else{
                print("Document does not exist")
                escapingHandler(result)
            }
            
            
        }
        print("*함수 종료 \(result)")
    }
    // 날짜 데이터 가져오기
    func getDate() -> String {
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let kr = date.string(from: now)
        return kr
    }
    
    // 유저가 로그인 했는지 확인
    func haveUesr() {
        guard AppDelegate.user == nil else {return}
        let alert = UIAlertController(title: "유저가 없습니다", message: "로그인을 해주세요!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    /// 테이블뷰 당겼을때 데이터 새로 불러오기
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.replyTableView.viewWithTag(4)?.isHidden = true
//        replyList.removeAll()
        DataLoad()
        
    }
  
    /// 메일 에러 메시지
    func showSendMailErrorAlert() {
            let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) {
                (action) in
                print("확인")
            }
            sendMailErrorAlert.addAction(confirmAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
    
    /// 메일 보낸 뒤 메일 창 닫기
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    
    func habitDataLoad()  {
            //데이터 불러오기
        FireStoreService.db.collection("User").document(currentData.uid).collection("HabitCheck").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {

                for document in querySnapshot!.documents {
                    let value = document.data()
                    let cleanSelect_db = value["cleanSelect"] as? String ?? ""
                    let smokingSelect_db = value["smokingSelect"] as? Bool ?? false
                    let gameSelect_db = value["gameSelect"] as? Bool ?? false
                    let snoringSelect_db = value["snoringSelect"] as? Bool ?? false
                    let griding_TeethSelect_db = value["griding_TeethSelect"] as? Bool ?? false
                    let callSelect_db = value["callSelect"] as? Bool ?? false
                    let eatSelect_db = value["eatSelect"] as? Bool ?? false
                    let curfewSelect_db = value["curfewSelect"] as? Bool ?? false
                    let bedtimeSelect_db = value["bedtimeSelect"] as? Bool ?? false
                    let mbtiSelect_db = value["mbtiSelect"] as? String ?? ""
                    
                    userHabitCheck.removeAll()
                    userHabitCheck.append(HabitCheck(cleanSelect: cleanSelect_db, smokingSelect: smokingSelect_db, gameSelect: gameSelect_db, snoringSelect: snoringSelect_db, griding_teethSelect: griding_TeethSelect_db, callSelect: callSelect_db, eatSelect: eatSelect_db, curfewSelect: curfewSelect_db, bedtimeSelect: bedtimeSelect_db, mbtiSelect: mbtiSelect_db))
                }
    
       
            }
        }
    }
    
    //MARK: - Reply TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return replyList.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = replyTableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath)
        
        
        //  둥근 테두리 만들기
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = color.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
//        cell.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        
        let userLabel = cell.viewWithTag(1) as! UILabel
        let contentsText = cell.viewWithTag(2) as! UITextView
        let dateLabel = cell.viewWithTag(3) as! UILabel
        let replyDeleteLabel = cell.viewWithTag(4) as! UIButton
        

        if replyList.count > 0{
            // 텍스트 크기 자동조절
            userLabel.text = self.replyList[indexPath.section].author
            userLabel.sizeToFit()
            contentsText.text = self.replyList[indexPath.section].contents
            contentsText.sizeToFit()
            dateLabel.text = self.replyList[indexPath.section].date
            dateLabel.sizeToFit()
            
            // 삭제 버튼 확이
            replyDeleteLabel.isHidden = true
            if Auth.auth().currentUser == nil || Auth.auth().currentUser?.uid != self.replyList[indexPath.section].uid   {
                replyDeleteLabel.isHidden = true
            }
            print("$$$\(self.replyList[indexPath.section].uid): \(Auth.auth().currentUser?.uid)")
            if self.check_replyuser[indexPath.section] {
                replyDeleteLabel.isHidden = false
            }
//            if self.replyList[indexPath.section].uid != Auth.auth().currentUser?.uid {
//                replyDeleteLabel.isHidden = true
//            }
//            else {}
            
        }
        else {}
        
        return cell
    }

    //MARK: - 화면 전환
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "surveyView" {
            let VCDest = segue.destination as! SurveyViewController
            VCDest.surveyView_user_id=send_username
            guard userHabitCheck != nil else {return}
            VCDest.surveyView_cont = userHabitCheck[0]

        }
        else {}
    }
    
    // MARK: - 키보드 세팅
    /// textview 높이 자동조절
    func textViewDidChange(_ textView: UITextView) {
            
            let size = CGSize(width: view.frame.width, height: .infinity)
            let estimatedSize = textView.sizeThatFits(size)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        //화면-키보드 값 계산
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.size.height >= viewHeight {
                self.view.frame.size.height -= keyboardSize.height
            }
        }
        print("## keyboardWillShow")
    }
        
    @objc func keyboardWillHide() {
        self.view.frame.size.height = viewHeight
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
}
