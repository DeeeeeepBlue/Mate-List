//
//  ScrapCellUsecase.swift
//  FeatScrap
//
//  Created by 강민규 on 2023/03/07.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import RxSwift

import Service

class ScrapCellUsecase {
    static func getHabitCheck(uid: String) -> Observable<HabitCheck> {
        return IDFirestoreRepository
            .habitCheck(uid: uid)
    }
    
    static func getMyUID() -> Observable<String> {
        return IDFirestoreRepository
            .myUID()
    }
    
}
