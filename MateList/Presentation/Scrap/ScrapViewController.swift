//
//  ScrapViewController.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/25.
//

import UIKit
import Firebase
import RxCocoa
import RxSwift


class ScrapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: - Properties
    @IBOutlet var scrapTableView: UITableView!
    
    var scrapTableViewController = UITableViewController()
   
    var ref: DocumentReference? = nil
    var posts : [Post] = []
    let relay = BehaviorRelay(value: [Post]())
    
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        posts.removeAll()
        
        self.dataLoad()
        self.reloadTableView()
        self.setEmptyView()
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
    func setEmptyView(){
        lazy var emptyView : UIView = {
            let v = UIView()
            let lb = UILabel()
            lb.text = "Empty!"
            lb.textColor = .gray
            v.addSubview(lb)
            lb.snp.makeConstraints {$0.center.equalToSuperview()}
            v.isHidden = true
            return v
        }()
        
        
        self.view.addSubview(emptyView)
        
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        // BehaviorRelay
        relay.asObservable()
            .subscribe{ event in
                let result = event.element ?? []
                if result.isEmpty {
                    emptyView.isHidden = false
                } else {
                    emptyView.isHidden = true
                }
            }
        
    }
    
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
    
    func dataLoad() {
        posts.removeAll()
            //데이터 불러오기\
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
                            let pid = document.documentID
                            let uid = value["uid"] as? String ?? "글이 없습니다."
                            let author = value["user"] as? String ?? "글이 없습니다."
                            let title = value["title"] as? String ?? "글이 없습니다."
                            let contents = value["contents"] as? String ?? "글이 없습니다."
                            let date = value["date"] as? String ?? "글이 없습니다."
                            let isScrap = value["isScrap"] as? Bool ?? false
                            let findMate = value["findMate"] as? Bool ?? false
                            
                            existScrap(docPath: document.documentID){ (result) in
                                if result{
                                    self.posts.append(Post(pid: pid, uid: uid, title: title, contents: contents, date: date, isScrap: isScrap, findMate: findMate ))
                                    print("잘 넣었음")
                                    self.reloadTableView()
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
    func reloadTableView() {
        self.scrapTableView.reloadData()
        // 🛠 Rx
        self.relay.accept(self.posts)
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var value : Int
        if(self.posts.count<=0){
            value = 0
        } else {
            value = self.posts.count
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
         
        if self.posts.count > 0 {
            
            // List가 0보다 클때만 데이터 불러오기
            let cellTittle = cell.viewWithTag(3) as! UILabel
            let cellContents = cell.viewWithTag(4) as! UILabel
            let cellDate = cell.viewWithTag(5) as! UILabel
            let cellUser = cell.viewWithTag(6) as! UILabel
            let cellSameLabel = cell.viewWithTag(7) as! UILabel
            let cellSameNumber = cell.viewWithTag(8)!
            let cellSameNumberLabel: UILabel! = cellSameNumber.subviews[0] as! UILabel
            print(self.posts.count)

            cellTittle.text = "\(self.posts[indexPath.section].title)"
            cellContents.text = "\(self.posts[indexPath.section].contents)"
            cellDate.text = "\(self.posts[indexPath.section].date)"
            cellUser.text = "\(self.posts[indexPath.section].uid)"
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
         self.reloadTableView()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            
            let findMateTableViewIndexPath = scrapTableView.indexPath(for: sender as! UITableViewCell)!
            let VCDest = segue.destination as! ContentsDetailViewController

            VCDest.contentsDetailData = posts[findMateTableViewIndexPath.section]
            
        }
        else {}
    }

}
