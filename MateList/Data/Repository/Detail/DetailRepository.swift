//
//  DetailRepository.swift
//  MateList
//
//  Created by 강민규 on 2023/01/13.
//

import UIKit

import RxSwift

class DetailRepository {
    func fetchComments(pid: String) -> Observable<[String:Any]> {
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
}

