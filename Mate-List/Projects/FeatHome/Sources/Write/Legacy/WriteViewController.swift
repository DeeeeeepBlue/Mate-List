//
//  WriteViewController.swift
//  checkMate
//
//  Created by 한상윤 on 2022/02/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import RxSwift
import RxCocoa

import Service
import Utility

class WriteViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var tittleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var nickName = ""
    
    //MARK: - IBAction
    /// 글쓰기 저장 버튼
    @IBAction func saveButton(_ sender: Any) {
        // 유저 이름 분리하기
        
        var userName = nickName
    
        
        // 텍스트 필드의 입력된 텍스트를 상수로 지정
        let titleText = tittleTextField.text
        let contentText = contentTextView.text
        
        
        // Firestore에 데이터 올리는 코드
        if contentText!.trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty||titleText!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty||contentText!=="Fill the content."{
            let alert = UIAlertController(title: "내용 없음", message: "내용을 입력해 주세요!", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        else if contentText!.count>100||titleText!.count>15{
            if titleText!.count>15 {
                print("####alert실행");
                let alert = UIAlertController(title: "글자 수 초과!", message: "제목 15자 이내로 작성해 주세요", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .default) {_ in
                }
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }else{
                print("####alert실행");
                let alert = UIAlertController(title: "글자 수 초과!", message: "100자 이내로 작성해 주세요", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .default) {_ in
                }
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }else{
            var ref: DocumentReference? = nil
            ref = FireStoreService.db.collection("Post").addDocument(data: [
                "reg" : true,
                "contents" : contentText!,
                "title" : titleText!,
                "uid" : Auth.auth().currentUser!.uid,
                "user" : userName,
                "date" : getDate(),
                "findMate" : false,
                "isScrap" : false
            ])
            self.navigationController?.popViewController(animated: true)
        }
        // 모달 종료
        
    }
    

    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        haveUesr()
        getNickName()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        placeholderSetting()
        
        writeButton.layer.cornerRadius = 20
        writeButton.layer.borderWidth = 0.5
        writeButton.layer.borderColor = UIColor.gray.cgColor
        
        // Do any additional setup after loading the view.
    }
  
    // MARK: - Custom Function
    /// 닉네임 가져오기
    func getNickName(){
        guard let user = Auth.auth().currentUser else { return }
        FireStoreService.db.collection("User").document(user.uid).getDocument { documentSnapshot, err in
            guard let document = documentSnapshot else {
                print("ERR: \(err)")
                return
            }
            guard let data = document.data() else {
                print("Document Empty")
                return
            }
            self.nickName = data["NickName"] as! String
        }
    }
    
    /// 날짜 가져오기
    func getDate() -> String {
        let now = Date()
        let date = DateFormatter()
        date.locale = Locale(identifier: "ko_kr")
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let kr = date.string(from: now)
        return kr
    }
    
    /// 유저가 로그인 했는지 확인
    func haveUesr() {
        //TODO: [AppDelegate] Auth 고치기 5
        //guard AppDelegate.userAuth == nil else {return}
        let alert = UIAlertController(title: "유저가 없습니다", message: "로그인을 해주세요!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    /// 텍스트뷰 플레이스 홀더 코드
    func placeholderSetting() {
        contentTextView.delegate = self
        contentTextView.text = "Fill the content."
        contentTextView.textColor = UIColor.lightGray
        
    }
    
    
    /// 텍스트뷰 플레이스 홀더 코드
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextView.textColor == UIColor.lightGray {
            contentTextView.text = nil
            contentTextView.textColor = UIColor.black
        }
        
    }
    
    /// 텍스트뷰 플레이스 홀더 코드
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text.isEmpty {
            contentTextView.text = "Fill the content."
            contentTextView.textColor = UIColor.lightGray
        }
    }

}
