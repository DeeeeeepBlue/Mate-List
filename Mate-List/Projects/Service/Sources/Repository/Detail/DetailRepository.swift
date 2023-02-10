//
//  DetailRepository.swift
//  MateList
//
//  Created by 강민규 on 2023/01/13.
//

import UIKit

import RxSwift

public class DetailRepository: DetailRepositoryProtocol {
    
    var disposeBag = DisposeBag()
    
    public init() {}
    
    public func fetchComments(pid: String) -> Observable<[String:Any]> {
        return Observable.create { observer in
            FireStoreService.db.collection("Post").document(pid).collection("Comment").order(by: "date", descending: true).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        observer.onNext(data)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    public func isScrap(uid: String, pid: String) -> Observable<Bool> {
        var result: Bool = false
        return Observable.create { observer in
            FireStoreService.db.collection("User").document(uid).collection("Scrap").document(pid).getDocument { (document, error) in
                if let document = document, document.exists {
                    guard let dataDescription = document.data() else { return }
                    let describingData = dataDescription["isScrap"] ?? "0"
                    let isScrapValue = String(describing: describingData)
                    
                    result = isScrapValue == "1"
                    print(isScrapValue, result)
                    print("Document data: \(dataDescription)")
                    
                }
                observer.onNext(result)
            }
            
            return Disposables.create()
        }
    }
    
    public func deleteScrap(uid: String, pid: String) {
        FireStoreService.db.collection("User").document(uid).collection("Scrap").document(pid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

    public func registerScrap(uid:String, pid: String, post: Post) {
        FireStoreService.db.collection("User").document(uid).collection("Scrap").document(pid).setData([
            "contents" : post.contents,
            "title" :  post.title,
            "uid" : post.uid,
            "user" : post.uid,
            "date" : post.date,
            "findMate" : false,
            "isScrap" : true
        ])
    }
    
    public func deletePost(pid: String) {
        // Post 삭제
        FireStoreService.db.collection("Post").document(pid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        // Post에 있는 Comment 삭제
        FireStoreService.db.collection("Post").document(pid).collection("Comment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    FireStoreService.db.collection("Post").document(pid).collection("Comment").document(document.documentID).delete()
                }
            }
        }
    }
    
    
    public func deleteComment(pid: String, cid: String) {
        // 댓글의 문서 id 삭제
        FireStoreService.db.collection("Post").document(pid).collection("Comment").document(cid).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
        }
    }
}
