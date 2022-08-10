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



class SurveyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var selectedCountry: String?



    @IBOutlet weak var surveyviewtitle: UILabel!
    @IBOutlet weak var regbutton: UILabel!
    var surveyView_user_id :String!
    var  surveyView_cont : HabitCheck!
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
        
        surveyviewtitle.text = surveyView_user_id + " 님의 생활패턴"
    }
    
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitCheck.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)as! ServeyViewCell
        
        cell.myLabel.text = habitCheck[indexPath.row]
        
        guard surveyView_cont != nil else {
            cell.value.text = "선택안함"
            return cell
        }
        
        if cell.myLabel.text == "청소주기" {
            cell.value.text =  surveyView_cont.cleanSelect
        }
        else if cell.myLabel.text == "흡연" {
            if(String(surveyView_cont.smokingSelect ?? false) == "true"){
                cell.value.text = "O"
            } else {
                cell.value.text = "X"
            }
        }
        else if cell.myLabel.text == "게임" {
            if(String(surveyView_cont.gameSelect ?? false) == "true"){
                cell.value.text = "O"
            } else {cell.value.text = "X"}
        }
        else if cell.myLabel.text == "코골이" {
            if(String(surveyView_cont.snoringSelect ?? false) == "true"){
                cell.value.text = "O"
            } else {cell.value.text = "X"}
        }
        else if cell.myLabel.text == "이갈이" {
            if(String(surveyView_cont.griding_teethSelect ?? false) == "true"){
                cell.value.text = "O"
            } else {cell.value.text = "X"}
        }
        else if cell.myLabel.text == "방에서 통화" {
            if(String(surveyView_cont.callSelect ?? false) == "true"){
                cell.value.text = "O"
            } else {cell.value.text = "X"}
            
        }
        else if cell.myLabel.text == "방에서 음식섭취" {
            if(String(surveyView_cont.eatSelect ?? false) == "true"){
                cell.value.text = "O"
            } else {cell.value.text = "X"}
        }
        else if cell.myLabel.text == "귀가 시간(11시 이후)" {
            if(String(surveyView_cont.curfewSelect ?? false) == "true"){
                cell.value.text = "O"
            } else {cell.value.text = "X"}
        }
        else if cell.myLabel.text == "취침 시간(12시 이후)" {
            if(String(surveyView_cont.bedtimeSelect ?? false) == "true"){
                cell.value.text = "O"
            } else {cell.value.text = "X"}
        }
        else if cell.myLabel.text == "mbti" {
            cell.value.text =  surveyView_cont.mbtiSelect
        }
        else {cell.value.text = "선택안함"}
        
       
        return cell
    
    }



    @IBAction func done(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
