//
//  FirestoreRepository.swift
//  MateList
//
//  Created by 강민규 on 2022/12/18.
//

import RxSwift

protocol DefaultFirestore {
    func fetchPost() -> Observable<[String:Any]>
    func fetchOtherSurvey(posts: [Post]) -> Observable<[String:HabitCheck]>
}
