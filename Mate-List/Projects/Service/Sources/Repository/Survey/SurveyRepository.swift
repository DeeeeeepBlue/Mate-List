//
//  SurveyRepository.swift
//  Service
//
//  Created by DOYEON LEE on 2023/03/05.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import UIKit
import RxSwift

public class SurveyRepository: SurveyRepositoryProtocol {
    
    var disposeBag = DisposeBag()
    
    public init() {}
    
    func putSurveyResult(with habitCheck: HabitCheck, pid: String) -> Observable<Bool> {
        return Observable.create { observer in
            FireStoreService.db.collection("User").document(pid).collection("Comment").order(by: "date", descending: true).getDocuments { (querySnapshot, err) in
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

//FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("HabitCheck").document(Auth.auth().currentUser!.uid).setData(select) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//        self.navigationController?.popViewController(animated: true)
