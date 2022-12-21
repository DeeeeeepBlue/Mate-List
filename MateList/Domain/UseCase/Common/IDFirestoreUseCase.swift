//
//  IDFirestoreUseCase.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import RxSwift

class IDFirestoreUseCase: IDFireStoreUseCaseProtocol {

    static func getUserName(uid: String) -> Observable<String> {
        return IDFirestoreRepository
            .userName(uid: uid)
    }
    
    static func getHabitCheck(uid: String) -> Observable<HabitCheck> {
        return IDFirestoreRepository
            .habitCheck(uid: uid)
    }
    
    static func getMyUID() -> Observable<String> {
        return IDFirestoreRepository
            .myUID()
    }
}
