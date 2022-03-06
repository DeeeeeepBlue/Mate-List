//
//  ContentsTableViewController.swift
//  checkMate
//
//  Created by 한상윤 on 2022/01/29.
//

import Foundation
import UIKit
import Firebase

class FindMateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var findMateTableView: UITableView!
    
    var findMateTableViewController = UITableViewController()
    let db = Firestore.firestore()
    var List : [Post] = []
    var dbID: String = ""
    
    // Add a new document with a generated ID
    var ref: DocumentReference? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        DataLoad()
//        findMateTableView.reloadData()
    }
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()


            self.findMateTableView.delegate = self
            self.findMateTableView.dataSource = self
    
            self.findMateTableViewController.tableView.delegate = self
            self.findMateTableViewController.tableView.dataSource = self
            findMateTableView.reloadData()
    
            //         테두리 여백 만들기
            self.findMateTableView.frame = self.findMateTableView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
 
    }

    
    
    func DataLoad() {
        List.removeAll()
        self.db.collection("Post").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    //querySnapshot!.documents : Array -> 딕셔너리 타입임 data() 함수 사용시 내용 확인 가능
                    //ex) let value = querySnapshot!.documents[0].data()
                    //    value["callSelect", default: 0]
                    for document in querySnapshot!.documents {
                        //print(document.data())
                        let value = document.data()

                        let uid_db = value["uid"] as? String ?? "글이 없습니다."
                        let author_db = value["user"] as? String ?? "글이 없습니다."
                        let title_db = value["title"] as? String ?? "글이 없습니다."
                        let content_db = value["contents"] as? String ?? "글이 없습니다."
                        let date_db = value["date"] as? String ?? "글이 없습니다."
                        let isScrap_db = value["isScrap"] as? Bool ?? false

    //                        let findMate = value["findMate"]! as! Bool


                        self.List.append(Post(uid: uid_db, author: author_db, title: title_db, contents: content_db, isScrap: isScrap_db, date: date_db, pid: document.documentID))

    //                    print("\(document.documentID) => \(document.data())")
                    }
                   
                }
            self.findMateTableView.reloadData()
            }
       }



    
    // indexPath.row 대신 indexPath.section으로 나눴음
    func numberOfSections(in tableView: UITableView) -> Int {
        var value : Int
        if(List.count<=0){
            value = 0
        } else {
            value = List.count
        }
        return value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15 // cell.indexPath.section*(numbert)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = self.findMateTableView.dequeueReusableCell(withIdentifier: "mateCell", for: indexPath)
        if self.List.count > 0 {
                // List가 0보다 클때만 데이터 불러오기
                let cellTittle = cell.viewWithTag(1) as! UILabel
                let cellUser = cell.viewWithTag(2) as! UILabel
                let cellContents = cell.viewWithTag(3) as! UILabel
                let cellDate = cell.viewWithTag(4) as! UILabel
                print(self.List.count)

                cellTittle.text = "\(self.List[indexPath.section].title)"
                cellUser.text = "\(self.List[indexPath.section].author)"
                cellContents.text = "\(self.List[indexPath.section].contents)"
                cellDate.text = "\(self.List[indexPath.section].date)"
            
            
        } else {}
    
        
//        cell.textLabel?.text = jinjuCastle[indexPath.row].name
        
//         둥근 테두리 만들기
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        // 필터
//        let found = findMateData.filter { info in
//            입력.name == 출력.name
        
//        cell.accessoryType = found.count == 0 ? .none : .checkmark
//        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let found = 데이터리스트.enumerated().filter { _, info in
//            입력.name == 출력.name
//        }
//
//        if found.count == 0 { // 추가 안된 데이터.
//            엄마 데이터.append(자식 데이터)
//        }
//        else { // 추가된 데이터
//            데이터 리스트.remove(at: found.first!.offset)
//        }
        tableView.reloadData()
    }
    
    
    // 당기면 데이터 리로드
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.findMateTableView.reloadData()
        
    }


    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            
            let findMateTableViewIndexPath = findMateTableView.indexPath(for: sender as! UITableViewCell)!
            let VCDest = segue.destination as! ContentsDetailViewController

            if List.count > 0 {
                VCDest.contentsDetailData = List[findMateTableViewIndexPath.section]
            }

        }
        else {}
    }
}
    

