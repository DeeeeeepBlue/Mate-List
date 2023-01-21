//
//  IDFirestoreRepository.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//
import Foundation

import RxSwift
import FirebaseAuth

class IDFirestoreRepository: IDFirestore {
    // MARK: Check
    func isExistUser(uid: String) -> Observable<Bool> {
        return Observable.create { observer in
            FireStoreService.db.collection("User").whereField("uid", isEqualTo: uid).getDocuments { (querySnapshot, err) in
                guard let documents = querySnapshot?.documents else { return }
                let data = documents.map{$0["uid"]!}
                
                observer.onNext(!data.isEmpty)
            }
            return Disposables.create()
        }
    }
    
    func isBlackUser(uid: String) -> Observable<Bool> {
        return Observable.create { observer in
            FireStoreService.db.collection("BlackList").whereField(uid, isEqualTo: true).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for _ in querySnapshot!.documents {
                        observer.onNext(true)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: Delete
    func deleteAllPost(uid: String) {
        var userPostsID: [String] = []
        FireStoreService.db.collection("Post").whereField("uid", isEqualTo: uid).getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    userPostsID.append(document.documentID)
                }
            }
        }
        
        for document_id in userPostsID {
            FireStoreService.db.collection("Post").document(document_id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    func deleteAllScrap(uid: String) {
        FireStoreService.db.collection("User").document(uid).collection("Scrap").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    FireStoreService.db.collection("User").document(uid).collection("Scrap").document(document.documentID).delete() { err in
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
    
    func deleteAllHabit(uid: String) {
        FireStoreService.db.collection("User").document(uid).collection("HabitCheck").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    FireStoreService.db.collection("User").document(uid).collection("HabitCheck").document(document.documentID).delete() { err in
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
    
     func deleteUser(uid: String) {
        FireStoreService.db.collection("User").document(uid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    // MARK: Read
    // Pid로 게시글 들고오기
    static func fetchPost(pid: String) -> Observable<Post> {
        return Observable.create { observer in
            let docRef = FireStoreService.db.collection("Post").document(pid)
            
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
                        let decodePost = try decoder.decode(Post.self, from: data)

                        observer.onNext(decodePost)
                    }
                    catch {
                        print("Error when trying to encode book: \(error)")
                    }

                }
            }
            
            return Disposables.create()
        }
    }
    
    static func userName(uid: String) -> Observable<String> {
        return Observable.create { observer in
            let docRef = FireStoreService.db.collection("User")
            
            docRef.getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if uid == document.documentID {
                            let data = document.data()
                            let name = data["NickName"]
                            observer.onNext(name as! String)
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    static func habitCheck(uid: String) -> Observable<HabitCheck> {
        return Observable.create { observer in
        
            let docRef = FireStoreService.db.collection("User").document(uid).collection("HabitCheck").document(uid)

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

                        observer.onNext(decodeHabitCheck)
                    }
                    catch {
                        print("Error when trying to encode book: \(error)")
                    }

                }
            }
            return Disposables.create()
        }
    }
    
    static func myUID() -> Observable<String> {
        return Observable.create { observer in
            if let currentUser = Auth.auth().currentUser {
                let uid = currentUser.uid
                observer.onNext(uid)
            } else {
                observer.onNext("jV0gO04mvSVQQQWQtCBcHOGedDA3")
            }
            return Disposables.create()
        }
    }
    
    //TODO: 나중에 고치기 
    static func myUIDString() -> String {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            return uid
        } else {
            return "jV0gO04mvSVQQQWQtCBcHOGedDA3"
        }
    }
    
    
    static func reportUser(myUid: String, reportUid: String) {
        FireStoreService.db.collection("User").document(myUid).collection("HateUser").document(reportUid).setData([
            reportUid : reportUid
        ])
    }
}
