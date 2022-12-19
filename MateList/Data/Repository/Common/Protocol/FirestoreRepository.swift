//
//  FirestoreRepository.swift
//  MateList
//
//  Created by 강민규 on 2022/12/18.
//

import RxSwift

protocol FirestoreRepository {
    func fetchData() -> Observable<[String:Any]> 
    func fetchMySurvey() -> Observable<HabitCheck>
    func fetchOtherSurvey(posts: [Post]) -> Observable<[String:HabitCheck]>
}
