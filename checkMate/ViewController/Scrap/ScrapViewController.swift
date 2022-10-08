//
//  ScrapViewController.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/25.
//

import UIKit
import Firebase


class ScrapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var scrapTableView: UITableView!
    
    var scrapTableViewController = UITableViewController()
   
    var ref: DocumentReference? = nil
    var List : [Post] = []
    
    // MARK: LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        List.removeAll()
        guard AppDelegate.userAuth != nil else {return self.scrapTableView.reloadData()}
        DataLoad()
        self.scrapTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrapTableView.delegate = self
        self.scrapTableView.dataSource = self

        self.scrapTableViewController.tableView.delegate = self
        self.scrapTableViewController.tableView.dataSource = self
        

        
        // 테두리 여백 만들기
        self.scrapTableView.frame = self.scrapTableView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        
        customNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Custom function
    
    func customNavigationBar(){
        //배경하고 그림자 없게
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    func existScrap(docPath:String, _ escapingHandler : @escaping (Bool) -> ()){
        var result = false
        FireStoreService.db.collection("Post").document(docPath).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                result = true
                escapingHandler(result)
            }else{
                print("Document does not exist")
                result = false
                escapingHandler(result)
            }
        }
    }
    
    func DataLoad() {
        List.removeAll()
            //데이터 불러오기
        guard Auth.auth().currentUser != nil else {return}
        FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").getDocuments() { [self] (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        //querySnapshot!.documents : Array -> 딕셔너리 타입임 data() 함수 사용시 내용 확인 가능
                        //ex) let value = querySnapshot!.documents[0].data()
                        //    value["callSelect", default: 0]
                        for document in querySnapshot!.documents {
                           // print(document.data())
                            let value = document.data()
                            let uid_db = value["uid"] as? String ?? "글이 없습니다."
                            let author_db = value["user"] as? String ?? "글이 없습니다."
                            let title_db = value["title"] as? String ?? "글이 없습니다."
                            let content_db = value["contents"] as? String ?? "글이 없습니다."
                            let date_db = value["date"] as? String ?? "글이 없습니다."
                            let isScrap_db = value["isScrap"] as? Bool ?? false
                            
                            
                            existScrap(docPath: document.documentID){ (result) in
                                if result{
                                    self.List.append(Post(uid: uid_db,author: author_db, title: title_db, contents: content_db, isScrap: isScrap_db, date: date_db, pid: document.documentID))
                                    print("잘 넣었음")
                                    
                                    self.scrapTableView.reloadData()
                                } else{
                                    FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").document(document.documentID).delete() { err in
                                        if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                            print("Document successfully removed!")
                                        }
                                    }
                                }
                                
                            }

                        }
                    }
                }
        }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var value : Int
        if(self.List.count<=0){
            value = 0
        } else {
            value = self.List.count
        }
        
        return value
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15 // cell.indexPath.section*(numbert)
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.scrapTableView.dequeueReusableCell(withIdentifier: "mateCell", for: indexPath)
         
        if self.List.count > 0 {
            
            // List가 0보다 클때만 데이터 불러오기
            let cellTittle = cell.viewWithTag(3) as! UILabel
            let cellContents = cell.viewWithTag(4) as! UILabel
            let cellDate = cell.viewWithTag(5) as! UILabel
            let cellUser = cell.viewWithTag(6) as! UILabel
            let cellSameLabel = cell.viewWithTag(7) as! UILabel
            let cellSameNumber = cell.viewWithTag(8)!
            let cellSameNumberLabel: UILabel! = cellSameNumber.subviews[0] as! UILabel
            print(self.List.count)

            cellTittle.text = "\(self.List[indexPath.section].title)"
            cellContents.text = "\(self.List[indexPath.section].contents)"
            cellDate.text = "\(self.List[indexPath.section].date)"
            cellUser.text = "\(self.List[indexPath.section].author)"
            cellSameNumberLabel.text = "홈에서 확인"
            cellSameNumberLabel 
        }
        
        else {
            
        }

        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.reloadData()
    }
    
    // 당기면 데이터 리로드
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
         self.scrapTableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            
            let findMateTableViewIndexPath = scrapTableView.indexPath(for: sender as! UITableViewCell)!
            let VCDest = segue.destination as! ContentsDetailViewController

            VCDest.contentsDetailData = List[findMateTableViewIndexPath.section]
            
        }
        else {}
    }

}
