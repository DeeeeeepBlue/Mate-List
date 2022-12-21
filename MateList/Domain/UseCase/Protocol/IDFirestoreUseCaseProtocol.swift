//
//  IDFirestoreUseCaseProtocol.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import RxSwift

protocol IDFireStoreUseCaseProtocol {
    static func getUserName(uid: String) -> Observable<String>
    static func getHabitCheck(uid: String) -> Observable<HabitCheck>
    static func getMyUID() -> Observable<String>
}
