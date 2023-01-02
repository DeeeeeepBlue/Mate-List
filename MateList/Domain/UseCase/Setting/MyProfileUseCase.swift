//
//  MyProfileUseCase.swift
//  MateList
//
//  Created by 강민규 on 2023/01/02.
//

import RxSwift

protocol MyProfileUseCaseProtocol {
    var name: BehaviorSubject<String> { get }
    var email: BehaviorSubject<String> { get }
    var isUser: BehaviorSubject<Bool> { get }
    func isCurrentUser()
    func currentUserName()
    func currentUserEmail()
}

class MyProfileUseCase: MyProfileUseCaseProtocol {
    var name = BehaviorSubject<String>(value: "이름 없음")
    var email = BehaviorSubject<String>(value: "이메일 없음")
    var isUser = BehaviorSubject<Bool>(value: false)
    
    func isCurrentUser() {
        AppDelegate.userAuth.subscribe(onNext: { result in
            self.isUser.onNext(result != nil)
        })
    }
    
    func currentUserName() {
        AppDelegate.userAuth.subscribe(onNext: { result in
            guard let result = result else { return }
            self.name.onNext(result.user.displayName ?? "이름 없음")
        })
    }
    
    func currentUserEmail() {
        AppDelegate.userAuth.subscribe(onNext: { result in
            guard let result = result else { return }
            self.email.onNext(result.user.email ?? "이메일 없음")
        })
    }
}
