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



class LifePatternViewController2: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var selectedCountry: String?



    
    @IBOutlet weak var regbutton: UILabel!
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
        
        
    }
    
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitCheck.count
    }
    
//    let dropDown = DropDown()
//    dropDown.dataSource = ["피자", "치킨", "족발보쌈", "치즈돈까스", "햄버거"]
//    dropDown.show()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)as! serveyviewViewCell
        cell.myLabel.text = habitCheck[indexPath.row]
        print("라벨")
        print(cell.myLabel.text)
        if cell.myLabel.text == "청소주기" {
            cell.value.text =  userHabitCheck[0].cleanSelect
        } else if cell.myLabel.text == "흡연" {
            cell.value.text =  String(userHabitCheck[0].smokingSelect ?? false)
        }else if cell.myLabel.text == "게임" {
            cell.value.text =  String(userHabitCheck[0].gameSelect ?? false)
        }else if cell.myLabel.text == "코골이" {
            cell.value.text =  String(userHabitCheck[0].snoringSelect ?? false)
        }else if cell.myLabel.text == "이갈이" {
            cell.value.text =  String(userHabitCheck[0].griding_teethSelect ?? false)
        }else if cell.myLabel.text == "방에서 통화" {
            cell.value.text =  String(userHabitCheck[0].callSelect ?? false)
        }else if cell.myLabel.text == "방에서 음식섭취" {
            cell.value.text =  String(userHabitCheck[0].eatSelect ?? false)
        }else if cell.myLabel.text == "귀가 시간(11시 이후)" {
            cell.value.text =  String(userHabitCheck[0].curfewSelect ?? false)
        }else if cell.myLabel.text == "취침 시간(12시 이후)" {
            cell.value.text =  String(userHabitCheck[0].bedtimeSelect ?? false)
        }else if cell.myLabel.text == "mbti" {
            cell.value.text =  userHabitCheck[0].mbtiSelect
        } else {cell.value.text = "없음"}
       
        return cell
    
    }



    @IBAction func done(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
