//
//  LifePatternViewController.swift
//  checkMate
//
//  Created by 한상윤 on 2022/02/28.
//

import UIKit
import Firebase
import FirebaseDatabase


class LifePatternViewController: UIViewController {

    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    var contentsDetailData: Post!

    
    let db = Firestore.firestore()
    var lef: DatabaseReference!
    
    // Add a new document with a generated ID
    var ref: DocumentReference? = nil
    
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
    
//    func finishDataLoad () async {
//        await DataLoad()
//    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        userHabitCheck.removeAll()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tittleLabel.text = "\(currentData.author)님의 생활 패턴"
        
        if userHabitCheck.count > 0 {
            let cleanSelectLabel = self.view.viewWithTag(1) as! UILabel
            cleanSelectLabel.text = userHabitCheck[0].cleanSelect
            let smokingSelectLabel = self.view.viewWithTag(2) as! UILabel
            smokingSelectLabel.text = String(userHabitCheck[0].smokingSelect ?? false)
            let gameSelectLabel = self.view.viewWithTag(3) as! UILabel
            gameSelectLabel.text = String(userHabitCheck[0].gameSelect ?? false)
            let snoringSelectLabel = self.view.viewWithTag(4) as! UILabel
            snoringSelectLabel.text = String(userHabitCheck[0].snoringSelect ?? false)
            let mbtiSelectLabel = self.view.viewWithTag(5) as! UILabel
            mbtiSelectLabel.text = userHabitCheck[0].mbtiSelect
            let griding_TeethSelectLabel = self.view.viewWithTag(6) as! UILabel
            griding_TeethSelectLabel.text = String(userHabitCheck[0].griding_teethSelect ?? false)
            let callSelectLabel = self.view.viewWithTag(7) as! UILabel
            callSelectLabel.text = String(userHabitCheck[0].callSelect ?? false)
            let eatSelectLabel = self.view.viewWithTag(8) as! UILabel
            eatSelectLabel.text = String(userHabitCheck[0].eatSelect ?? false)
            let curfewSelectLabel = self.view.viewWithTag(9) as! UILabel
            curfewSelectLabel.text = String(userHabitCheck[0].curfewSelect ?? false)
            let bedtimeSelectLabel = self.view.viewWithTag(10) as! UILabel
            bedtimeSelectLabel.text = String(userHabitCheck[0].bedtimeSelect ?? false)
        }
        
        
//        tittleLabel.text = currentData.author
        
        okButton.layer.borderWidth = 1
        okButton.layer.cornerRadius = 8
//        userHabitCheck.removeAll()
        print(userHabitCheck)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: Any) {
        print(userHabitCheck.count)
//        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }

//    func DataLoad()  {
//            //데이터 불러오기
//        db.collection("User").document(currentData.uid).collection("HabitCheck").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//
//                for document in querySnapshot!.documents {
//                    let value = document.data()
//                    let cleanSelect_db = value["cleanSelect"] as? String ?? ""
//                    let smokingSelect_db = value["smokingSelect"] as? Bool ?? false
//                    let gameSelect_db = value["gameSelect"] as? Bool ?? false
//                    let snoringSelect_db = value["snoringSelect"] as? Bool ?? false
//                    let griding_TeethSelect_db = value["griding_TeethSelect"] as? Bool ?? false
//                    let callSelect_db = value["callSelect"] as? Bool ?? false
//                    let eatSelect_db = value["eatSelect"] as? Bool ?? false
//                    let curfewSelect_db = value["curfewSelect"] as? Bool ?? false
//                    let bedtimeSelect_db = value["bedtimeSelect"] as? Bool ?? false
//                    let mbtiSelect_db = value["mbtiSelect"] as? String ?? ""
//
//                    self.userHabitCheck.append(HabitCheck(cleanSelect: cleanSelect_db, smokingSelect: smokingSelect_db, gameSelect: gameSelect_db, snoringSelect: snoringSelect_db, griding_teethSelect: griding_TeethSelect_db, callSelect: callSelect_db, eatSelect: eatSelect_db, curfewSelect: curfewSelect_db, bedtimeSelect: bedtimeSelect_db, mbtiSelect: mbtiSelect_db))
//
//
//
//                }
//
//            }
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
