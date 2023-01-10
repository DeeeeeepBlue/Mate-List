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
        let checking = BehaviorSubject<User>(value: Dummy.mingyu)
        
        AppDelegate.userAuth
            .map {
                guard let data = $0 else { return Dummy.mingyu }
                return User(uid: data.user.uid, email: data.user.email!, name: data.user.displayName ?? "err" , gender: "No", age: "No", habit: HabitCheck(cleanSelect: "", smokingSelect: false, gameSelect: false, snoringSelect: false, griding_teethSelect: false, callSelect: false, eatSelect: false, curfewSelect: false, bedtimeSelect: false, mbtiSelect: ""))}
            .bind(onNext: checking.onNext)
        
        _ = checking
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
