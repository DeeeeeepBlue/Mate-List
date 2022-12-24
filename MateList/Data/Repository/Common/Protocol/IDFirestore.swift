//
//  IDFirestore.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import RxSwift

protocol IDFirestore {
    static func userName(uid: String) -> Observable<String>
    static func habitCheck(uid: String) -> Observable<HabitCheck>
    static func myUID() -> Observable<String>
}
