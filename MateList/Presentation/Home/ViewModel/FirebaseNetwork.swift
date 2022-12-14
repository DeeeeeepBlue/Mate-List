//
//  FirebaseNetwork.swift
//  MateList
//
//  Created by 강민규 on 2022/12/14.
//

import RxSwift
import Firebase
import FirebaseAuth

protocol Fetchable {
    func posts() -> Observable<[Post]>
}

class FirebaseNetwork: Fetchable {
    func posts() -> Observable<[Post]> {
        return Observable.create { observer in
            var postItems: [Post] = []
            FireStoreService.db.collection("Post").order(by: "date", descending: true).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let value = document.data()
                        
                        let uid = value["uid"] as? String ?? "noID"
                        let author = value["user"] as? String ?? "noAuthor"
                        let title = value["title"] as? String ?? "noTitle"
                        let content = value["contents"] as? String ?? "noContent"
                        let date = value["date"] as? String ?? "noDate"
                        let isScrap = value["isScrap"] as? Bool ?? false
                        let pid = document.documentID
                        
                        postItems.append(
                            Post(
                                uid: uid,
                                author: author,
                                title: title,
                                contents: content,
                                isScrap: isScrap,
                                date: date,
                                pid: pid
                            )
                        )
                    }
                    observer.onNext(postItems)
                }
            }
            return Disposables.create()
        }
    }
}
