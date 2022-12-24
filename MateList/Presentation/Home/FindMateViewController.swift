//
//  ContentsTableViewController.swift
//  checkMate
//
//  Created by 한상윤 on 2022/01/29.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth


class FindMateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
// MARK: - ✅ Data & Outlet
    
    @IBOutlet weak var findMateTableView: UITableView!
    @IBOutlet var rootView: UIView!
    let MAX = 10000
    var posts : [Post] = []
    var habitCheckList : [String:HabitCheck] = [:] //key is uid
    var dbID: String = ""
    var loginUserSurvey : HabitCheck?
    
    // Add a new document with a generated ID
    var ref: DocumentReference? = nil
    
    
    // MARK: - ✅ Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        getLoginUserSurvey()
        DataLoad()
        
    }
    
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        self.findMateTableView.delegate = self
        self.findMateTableView.dataSource = self
    
        setView()
    
    }
    
    //MARK: - SetView
    func setView() {
        // 테두리 여백 만들기
        self.findMateTableView.frame = self.findMateTableView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))

        customNavigationBar()
        customTabBar()
        createWirteButton()
    }
    
    // MARK: - ✅ Custom Function
    @objc func tapWriteButton(sender:UIGestureRecognizer){
        performSegue(withIdentifier: "writeSegue", sender: nil)
    }
    
    func customNavigationBar(){
        //배경하고 그림자 없게
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    func customTabBar(){
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        
    }
    
    func createWirteButton(){
        //floating button - write button
        let writeButton: UIView = {
            let writeButtonBackground: UIView = UIView()
            let writeButtonText: UILabel = UILabel()
            
            writeButtonBackground.addSubview(writeButtonText)
            writeButtonBackground.translatesAutoresizingMaskIntoConstraints = false
            writeButtonBackground.backgroundColor = .white
            writeButtonBackground.widthAnchor.constraint(equalToConstant: 80).isActive = true
            writeButtonBackground.heightAnchor.constraint(equalToConstant: 35).isActive = true
            writeButtonBackground.layer.cornerRadius = 17.5
            writeButtonBackground.layer.borderWidth = 1
            writeButtonBackground.layer.borderColor = UIColor(rgb: 0xE5E5E5).cgColor
            
            writeButtonBackground.addSubview(writeButtonText)
            
            writeButtonText.text = "글쓰기"
            writeButtonText.font = UIFont.boldSystemFont(ofSize: 16)
            writeButtonText.textColor = .black
            writeButtonText.translatesAutoresizingMaskIntoConstraints = false
            writeButtonText.centerXAnchor.constraint(equalTo: writeButtonBackground.centerXAnchor).isActive = true
            writeButtonText.centerYAnchor.constraint(equalTo: writeButtonBackground.centerYAnchor).isActive = true
            
            
            //클릭이벤트
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapWriteButton(sender:)))
            writeButtonBackground.addGestureRecognizer(tapGesture)

            return writeButtonBackground
        }()
        
        view.addSubview(writeButton)
    
        writeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        writeButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        
    }

    
    func DataLoad() {
        posts.removeAll()
        FireStoreService.db.collection("Post").order(by: "date", descending: true).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let value = document.data()

                        let pid = document.documentID
                        let uid = value["uid"] as? String ?? "글이 없습니다."
                        let author = value["user"] as? String ?? "글이 없습니다."
                        let title = value["title"] as? String ?? "글이 없습니다."
                        let contents = value["contents"] as? String ?? "글이 없습니다."
                        let date = value["date"] as? String ?? "글이 없습니다."
                        let isScrap = value["isScrap"] as? Bool ?? false
                        let findMate = value["findMate"] as? Bool ?? false

                        self.posts.append(Post(pid: pid, uid: uid, title: title, contents: contents, date: date, isScrap: isScrap, findMate: findMate))
                    }
                }
            self.getPostHabitCheck()
            // 차단한 게시글 삭제
            guard let user = Auth.auth().currentUser else {
                self.findMateTableView.reloadData()
                return
            }
            FireStoreService.db.collection("User").document(user.uid).collection("HateUser").getDocuments { querySnapshot, err in
                if let err = err {
                    print("차단한 게시글 에러 : \(err)")
                } else{
                    guard let querySnapshot = querySnapshot else {return}
                    for document in querySnapshot.documents{
                        let hater = document.documentID
                        self.posts = self.posts.filter{$0.uid != hater}
                    }
                    self.findMateTableView.reloadData()
                }
            }
        }
        
        
        
    }
    
    /// 📌 로그인된 유저 survey 받아오기
    func getLoginUserSurvey(){
        guard Auth.auth().currentUser != nil else {return}
        if AppDelegate.userAuth != nil {
            let docRef = FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("HabitCheck").document(Auth.auth().currentUser!.uid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    //data load success.
                    do {
                        //딕셔너리 -> json객체 -> HabitCheck 객체 순으로 변환
                        let docData = document.data()!//딕셔너리 형 반환
                        //json 객체로 변환. withJSONObject 인자엔 Array, Dictionary 등 넣어주면 됨.
                        let data = try! JSONSerialization.data(withJSONObject: docData, options: [])
                        let decoder = JSONDecoder()
                        //첫번째 인자 : 해독할 형식(구조체), 두번째 인자 : 해독할 json 데이터
                        let decodeHabitCheck = try decoder.decode(HabitCheck.self, from: data)
                        self.loginUserSurvey = decodeHabitCheck
                        
                        } catch { print("Error when trying to encode book: \(error)") }

                    } else { print("Document does not exist") }
                }
            self.findMateTableView.reloadData()
        }
    }

// MARK: 버전 2에 사용
    /// 📌 각 POST 마다 author의 survey 받아오기
    func getPostHabitCheck(){
        // 한 유저가 여러개 글을 작성해도 한번만 저장되도록 중복 제거
        var writersUidList:[String] = self.posts.map { $0.uid }
        let writersUidSet = Set(writersUidList)
        writersUidList = Array(writersUidSet)
        
        habitCheckList.removeAll()
        
        // 글 작성한 유저들에 대해서 habitcheck을 받아온다. (유저 한명 당 한번만)
        for checkUid in writersUidList{
            let docRef = FireStoreService.db.collection("User").document(checkUid).collection("HabitCheck").document(checkUid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    //data load success
                    do {
                        //딕셔너리 -> json객체 -> HabitCheck 객체 순으로 변환
                        let docData = document.data()!//딕셔너리 형 반환
                        //json 객체로 변환. withJSONObject 인자엔 Array, Dictionary 등 넣어주면 됨.
                        let data = try! JSONSerialization.data(withJSONObject: docData, options: [])
                        let decoder = JSONDecoder()
                        //첫번째 인자 : 해독할 형식(구조체), 두번째 인자 : 해독할 json 데이터
                        let decodeHabitCheck = try decoder.decode(HabitCheck.self, from: data)
                        
                        self.habitCheckList[checkUid] = decodeHabitCheck
                        
                    } catch { print("Error when trying to encode book: \(error)") }
                    
                } else {
                    print("\(checkUid)'s Document does not exist")
                }
                self.findMateTableView.reloadData()
            }
        }
    }


    //MARK: - ✅ Table View function
    // indexPath.row 대신 indexPath.section으로 나눴음
    func numberOfSections(in tableView: UITableView) -> Int {
        var value : Int
        if(posts.count<=0){
            value = 0
        } else {
            value = posts.count
        }
        return value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5 // cell.indexPath.section*(numbert)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = self.findMateTableView.dequeueReusableCell(withIdentifier: "mateCell", for: indexPath)
        if self.posts.count > 0 {
                // List가 0보다 클때만 데이터 불러오기
                let cellTittle = cell.viewWithTag(3) as! UILabel
                let cellContents = cell.viewWithTag(4) as! UILabel
                let cellDate = cell.viewWithTag(5) as! UILabel
                let cellUser = cell.viewWithTag(6) as! UILabel
//                print(self.List.count)
                print(posts)
                print(indexPath)
                cellTittle.text = "\(self.posts[indexPath.section].title)"
                cellContents.text = "\(self.posts[indexPath.section].contents)"
                cellDate.text = "\(self.posts[indexPath.section].date)"
                cellUser.text = "\(self.posts[indexPath.section].uid)"
            
            
            /** 📌 적합도 계산 UI넣기 */
            // 로그인 X 일 때 실행
            let fitnessView = cell.viewWithTag(1)
            let fitnessText: UILabel! = fitnessView?.subviews[0] as! UILabel
            
            fitnessText.text = "로그인 필요"
            fitnessText.font = UIFont.boldSystemFont(ofSize: 14)
            fitnessText.textColor = .gray
            fitnessText.translatesAutoresizingMaskIntoConstraints = false
            fitnessText.centerXAnchor.constraint(
                equalTo: fitnessView!.centerXAnchor).isActive = true
            fitnessText.leftAnchor.constraint(equalTo: fitnessView!.leftAnchor
                    , constant: 0).isActive = true // 왼쪽여백
        

            if AppDelegate.userAuth != nil { //로그인되어있고 fitness 계산 완료됐으면 실행

                ///배경에 그라디언트 적용
                let gradient = CAGradientLayer()

                /// gradient colors in order which they will visually appear
                gradient.colors = [UIColor(rgb: 0x6795CF).cgColor,
                                   UIColor(rgb: 0x6764EE).cgColor]

                /// Gradient from left to right
                gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradient.endPoint = CGPoint(x: 1.0, y: 1.0)

                /// set the gradient layer to the same size as the view
                gradient.frame = fitnessView!.bounds
                /// add the gradient layer to the views layer for rendering
                fitnessView?.layer.addSublayer(gradient)
                
                //TODO: loginUserSurvey = nil Bug
                // fitness 계산
                let fitnessValue = 0
                
                // 적합도 값 넣기
                fitnessText.text = "\(fitnessValue ?? 0)%"
                
                // label만큼 그라디언트 적용
                fitnessView!.layer.mask = fitnessText.layer
   
            }
            /**  적합도 계산 UI넣기 END */
            
            
            
        } else {}
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
//        tableView.reloadData()
    }
    

    
    //MARK: - ✅ Scene Change
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            
            let findMateTableViewIndexPath = findMateTableView.indexPath(for: sender as! UITableViewCell)!
            let VCDest = segue.destination as! ContentsDetailViewController

            if posts.count > 0 {
                VCDest.contentsDetailData = posts[findMateTableViewIndexPath.section]
            }

        }
        else {}
    }
    
    // MARK: - ✅ v2.0.0때 마저 구현
    //    func setFilterButton(){
    //        self.filterButton.layer.cornerRadius = self.filterButton.frame.height/2
    //        self.filterButton.layer.borderColor = UIColor(rgb: 0xE5E5E5).cgColor
    //        self.filterButton.layer.borderWidth = 1
    //    }
    //
    //
    //    func setSearchBar(){
    //        self.searchBar.placeholder = "검색어를 입력해주세요"
    //        self.searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
    //        self.searchBar.searchTextField.backgroundColor = UIColor.clear
    //        self.searchBar.layer.borderColor = UIColor(rgb: 0xE5E5E5).cgColor
    //        self.searchBar.layer.borderWidth = 1
    //    }
}
    

