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



class ServeyInputViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var selectedCountry: String?

    @IBOutlet weak var regbutton: UILabel!
    
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
        
        regbutton.layer.cornerRadius=10
        regbutton.layer.borderWidth=1
        regbutton.layer.borderColor=UIColor.lightGray.cgColor
//        (displayP3Red: 229, green: 229, blue: 229, alpha: 1.0)
        surveytable.dataSource=self
        surveytable.delegate=self
        lef = Database.database().reference(withPath: "servey")
        
        
    }
    
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitCheck.count
    }
    
    var check : Bool = false
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)as! SurveyInputViewCell
        cell.myLabel.text =  habitCheck[indexPath.row]
        if cell.myLabel.text == "청소주기"{
            cell.dropView.isHidden = false
            cell.check_B.isHidden=true
        }else if cell.myLabel.text == "mbti"{
            cell.check_B.isHidden=true
        } else {
            cell.dropView.isHidden = true
            }

        return cell
    
    }
    
    /// 유저가 로그인 했는지 확인
    func haveUesr() {
        guard AppDelegate.userAuth == nil else {return}
        let alert = UIAlertController(title: "유저가 없습니다", message: "로그인을 해주세요!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }

    /// 딕셔너리로 파베에 저장
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
        
        FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("HabitCheck").document(Auth.auth().currentUser!.uid).setData(select) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        self.navigationController?.popViewController(animated: true)

    
        
        
    }
    
}
