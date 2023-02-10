//
//  IDFirestore.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import RxSwift

public protocol IDFirestore {
    static func userName(uid: String) -> Observable<String>
    static func habitCheck(uid: String) -> Observable<HabitCheck>
    static func myUID() -> Observable<String>
    static func fetchPost(pid: String) -> Observable<Post>
    
    func isExistUser(uid: String) -> Observable<Bool>
    func isBlackUser(uid: String) -> Observable<Bool>
    
    func deleteAllPost(uid: String)
    func deleteAllScrap(uid: String)
    func deleteAllHabit(uid: String)
    func deleteUser(uid: String)
    
}
