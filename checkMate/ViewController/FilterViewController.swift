//
//  FilterViewController.swift
//  checkMate
//
//  Created by 한상윤 on 2022/02/22.
//
import UIKit
import DropDown
import Firebase
import FirebaseDatabase

class FilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var lef: DatabaseReference!
    
    var id = 8
    
        @IBOutlet weak var survytabels: UITableView!
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
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            survytabels.dataSource=self
            survytabels.delegate=self
        }
    
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return habitCheck.count
        }
    
        var check : Bool = false

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)as! NewFilterTableViewCell
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
    
    
    
        @IBAction func submit(_ sender: Any) {
            
        }
    
    }
    

    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

//}
