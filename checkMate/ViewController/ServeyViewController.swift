//
//  ViewController.swift
//  mycheckmate
//
//  Created by 김가은 on 2022/02/02.
//

import UIKit
import DropDown
import Firebase
import FirebaseDatabase



class ServeyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var selectedCountry: String?
    var countryList = ["알제리", "안도라", "앙골라", "인도", "태국"]
   

    
    let db = Firestore.firestore()
    var lef: DatabaseReference!
    
    // Add a new document with a generated ID
    var ref: DocumentReference? = nil
    
    @IBOutlet weak var surveytable: UITableView!
 
    var habitCheck: [String] = [
        "청소주기",
        "흡연",
        "게임",
        "코골이",
        "이갈이",
        "방에서 통화",
        "방에서 음식섭취",
        "귀가 시간(11시 이후)",
        "취침 시간(12시 이후)",
        "mbti",
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        haveUesr()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        surveytable.dataSource=self
        surveytable.delegate=self
        lef = Database.database().reference(withPath: "servey")
        
        
    }
    
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitCheck.count
    }
    
    var check : Bool = false
//    let dropDown = DropDown()
//    dropDown.dataSource = ["피자", "치킨", "족발보쌈", "치즈돈까스", "햄버거"]
//    dropDown.show()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)as! MyTableViewCell
        cell.myLabel.text =  habitCheck[indexPath.row]
        if cell.myLabel.text == "청소주기"{
            cell.dropView.isHidden = false
            cell.check_B.isHidden=true
//            cleanSelect = cell.tfInput.text!
        }else if cell.myLabel.text == "mbti"{
            cell.check_B.isHidden=true
//            mbtiSelect = cell.tfInput.text!
        } else {
            cell.dropView.isHidden = true
            }

        return cell
    
    }
    
    // 유저가 로그인 했는지 확인
    func haveUesr() {
        guard AppDelegate.user == nil else {return}
        let alert = UIAlertController(title: "유저가 없습니다", message: "로그인을 해주세요!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }

    // 딕셔너리로 파베에 저장
    @IBAction func submit(_ sender: Any) {
        
        let select: [String: Any] = [
            "cleanSelect" : cleanSelect,
            "smokingSelect" : smokingSelect,
            "gameSelect" : gameSelect,
            "snoringSelect" : snoringSelect,
            "griding_teethSelect" : griding_teethSelect,
            "callSelect" : callSelect,
            "eatSelect" : eatSelect,
            "curfewSelect" : curfewSelect,
            "bedtimeSelect" : bedtimeSelect,
            "mbtiSelect" : mbtiSelect
        ]
        
        db.collection("User").document(Auth.auth().currentUser!.uid).collection("HabitCheck").document(Auth.auth().currentUser!.uid).setData(select) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        self.navigationController?.popViewController(animated: true)

        //데이터 불러오기
//        db.collection("HabitCheck").getDocuments() { (querySnapshot, err) in
//            if let erㄴr = err {
//                print("Error getting documents: \(err)")
//            } else {
//                //querySnapshot!.documents : Array -> 딕셔너리 타입임 data() 함수 사용시 내용 확인 가능
//                //ex) let value = querySnapshot!.documents[0].data()
//                //    value["callSelect", default: 0]
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//
//                }
//            }
//        }
    
        
        
    }
    
}
