//
//  DefaultFirestoreRepository.swift
//  MateList
//
//  Created by 강민규 on 2022/12/18.
//

import UIKit

import RxSwift

class DefaultFirestoreRepository : DefaultFirestore {
    
    // MARK: - 게시글들 들고오기
    func fetchPosts() -> Observable<[String:Any]> {
        return Observable.create { observer in
            FireStoreService.db.collection("Post").order(by: "date", descending: true).getDocuments { (querySnapshot, err) in
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

    // MARK: - 다른 사람들 설문조사 들고오기
    func fetchOtherSurvey(posts: [Post]) -> Observable<[String:HabitCheck]> {
        return Observable.create { observer in

            //key is uid
            var habitCheckList : [String:HabitCheck] = [:]

            // 한 유저가 여러개 글을 작성해도 한번만 저장되도록 중복 제거
            var writersUidList: [String] = posts.map { $0.uid }
            let writersUidSet = Set(writersUidList)
            writersUidList = Array(writersUidSet)

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


                            habitCheckList[checkUid] = decodeHabitCheck

                        } catch { print("Error when trying to encode book: \(error)") }

                    } else {
                        print("\(checkUid)'s Document does not exist")
                    }
                }
            }
            observer.onNext(habitCheckList)

            return Disposables.create()
        }
    }
}
