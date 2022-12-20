//
//  IDFirestoreRepository.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import RxSwift

class IDFirestoreRepository: IDFirestore {
    func userName(uid: String) -> Observable<String> {
        return Observable.create { observer in
            FireStoreService.db.collection("User").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if uid == document.documentID {
                            let data = document.data()
                            let name = data["nickName"]
                            observer.onNext(name as! String)
                        } else {
                            print("현재 유저가 없음")
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
}
