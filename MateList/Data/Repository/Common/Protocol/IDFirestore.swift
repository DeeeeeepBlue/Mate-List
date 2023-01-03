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
    
    static func isExistUser(uid: String) -> Observable<Bool>
    static func isBlackUser(uid: String) -> Observable<Bool>
    
    static func deleteAllPost(uid: String)
    static func deleteAllScrap(uid: String)
    static func deleteAllHabit(uid: String)
    static func deleteUser(uid: String)
    
}
