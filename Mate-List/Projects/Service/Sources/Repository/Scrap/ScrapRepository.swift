//
//  ScrapRepository.swift
//  Service
//
//  Created by 강민규 on 2023/03/12.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import Firebase
import RxSwift

public class ScrapRepository {
    /// Post 데이터 베이스에서 post 가져오기
    func existScrap(docPath: String) -> Observable<Bool> {
        return Observable.create { observer in
            FireStoreService.db.collection("Post").document(docPath).getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    observer.onNext(true)
                } else {
                    print("Document does not exist")
                    observer.onNext(false)
                }
            }
            return Disposables.create()
        }
    }
    
    /// User가 Scrap한 포스터들 가져오기
    func fetchScrapPosts(uid: String) -> Observable<[Post]> {
        return Observable.create { observer in
            FireStoreService.db.collection("User").document(uid).collection("Scrap").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var posts: [Post] = []
                    
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

                        let post = Post(pid: pid, uid: uid, title: title, contents: contents, date: date, isScrap: isScrap, findMate: findMate)
                        
                        posts.append(post)
                    }
                    
                    observer.onNext(posts)
                }
            }
            return Disposables.create()
        }
   }
    
    /// Scrap Post 삭제하기
    func deleteScrapPost(uid: String, pid: String) {
        FireStoreService.db.collection("User").document(uid).collection("Scrap").document(pid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
