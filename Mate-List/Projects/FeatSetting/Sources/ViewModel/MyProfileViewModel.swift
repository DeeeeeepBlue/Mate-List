//
//  MyProfileViewModel.swift
//  MateList
//
//  Created by 강민규 on 2022/12/31.
//

import UIKit

import RxSwift
import FirebaseAuth

import Network

protocol MyProfileViewModelProtocol {
    var name: Observable<String>? { get }
    var email: Observable<String>? { get }
}

class MyProfileViewModel: MyProfileViewModelProtocol {
    var disposeBag = DisposeBag()
    var myProfileUseCase: MyProfileUseCaseProtocol
    var settingRepository: SettingRepositoryProtocol
    
    var name: Observable<String>?
    var email: Observable<String>?
    
    let checking = PublishSubject<Network.User>()
    
    init(usecase: MyProfileUseCaseProtocol, repository: SettingRepositoryProtocol) {
        let checking = PublishSubject<Network.User>()
        
        myProfileUseCase = usecase
        settingRepository = repository
        
        self.bind()
    }
    
    func bind() {
        //TODO: [AppDelegate] Auth 고치기 5
//
//        AppDelegate.userAuth
//            .compactMap{ $0 }
//            .map{ User(uid: $0?.user.uid ?? "err",
//                       email: $0?.user.email ?? "err",
//                       name: $0?.user.displayName ?? "err",
//                       gender: "no",
//                       age: "no",
//                       habit: HabitCheck(cleanSelect: "",
//                                         smokingSelect: false,
//                                         gameSelect: false,
//                                         snoringSelect: false,
//                                         griding_teethSelect: false,
//                                         callSelect: false,
//                                         eatSelect: false,
//                                         curfewSelect: false,
//                                         bedtimeSelect: false,
//                                         mbtiSelect: "")
//                       )
//               }
//            .bind(onNext: checking.onNext)
//
        
        _ = checking
            .compactMap{ $0 }
            .subscribe(onNext: { user in
                self.settingRepository.registUser(user: user)
            })
        
        name = checking
            .flatMap { _ in self.myProfileUseCase.name}
        
        email = checking
            .flatMap { _ in self.myProfileUseCase.email}
        
        myProfileUseCase.isCurrentUser()
        myProfileUseCase.currentUserName()
        myProfileUseCase.currentUserEmail()
    
    }
}
