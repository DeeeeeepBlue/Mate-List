//
//  MyProfileViewModel.swift
//  MateList
//
//  Created by 강민규 on 2022/12/31.
//

import UIKit

import RxSwift
import FirebaseAuth

protocol MyProfileViewModelProtocol {
    var name: Observable<String> { get }
    var email: Observable<String> { get }
}

class MyProfileViewModel: MyProfileViewModelProtocol {
    var disposeBag = DisposeBag()
    var name: Observable<String>
    var email: Observable<String>
    
    
    init(myProfileUseCase: MyProfileUseCaseProtocol, repository: SettingRepositoryProtocol) {
        let checking = BehaviorSubject<User?>(value: nil)
        
        AppDelegate.userAuth
            .compactMap{ $0 }
            .map{ User(uid: $0?.user.uid ?? "err",
                       email: $0?.user.email ?? "err",
                       name: $0?.user.displayName ?? "err",
                       gender: "no",
                       age: "no",
                       habit: HabitCheck(cleanSelect: "",
                                         smokingSelect: false,
                                         gameSelect: false,
                                         snoringSelect: false,
                                         griding_teethSelect: false,
                                         callSelect: false,
                                         eatSelect: false,
                                         curfewSelect: false,
                                         bedtimeSelect: false,
                                         mbtiSelect: "")
                       )
               }
            .bind(onNext: checking.onNext)
        
        _ = checking
            .compactMap{ $0 }
            .subscribe(onNext: { user in
                repository.registUser(user: user)
            })
        
        name = checking
            .flatMap { _ in myProfileUseCase.name}
        
        email = checking
            .flatMap { _ in myProfileUseCase.email}
        
        myProfileUseCase.isCurrentUser()
        myProfileUseCase.currentUserName()
        myProfileUseCase.currentUserEmail()
    
    }
}
