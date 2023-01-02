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
    
    
    init(myProfileUseCase: MyProfileUseCaseProtocol) {
        let checking = BehaviorSubject<Bool>(value: false)
        
        AppDelegate.userAuth
            .map{ $0 != nil }
            .bind(onNext: checking.onNext)
        
        name = checking
            .flatMap { _ in myProfileUseCase.name}
        
        email = checking
            .flatMap { _ in myProfileUseCase.email}
        
        myProfileUseCase.isCurrentUser()
        myProfileUseCase.currentUserName()
        myProfileUseCase.currentUserEmail()
    
    }
}
