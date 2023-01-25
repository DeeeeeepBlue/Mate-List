//
//  FirestoreRepository.swift
//  MateList
//
//  Created by 강민규 on 2022/12/18.
//

import RxSwift

public protocol DefaultFirestore {
    func fetchPosts() -> Observable<[String:Any]>
    func fetchOtherSurvey(posts: [Post]) -> Observable<[String:HabitCheck]>
}
