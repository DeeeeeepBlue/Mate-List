//
//  MyProfileViewModel.swift
//  MateList
//
//  Created by 강민규 on 2022/12/31.
//

import UIKit

import RxSwift

protocol MyProfileViewModelProtocol {
    var fetchUser: AnyObserver<User> { get }
    
    var name: Observable<String> { get }
    var email: Observable<String> { get }
}

class MyProfileViewModel: MyProfileViewModelProtocol {
    var fetchUser: AnyObserver<User> 
    
    var name: Observable<String>
    var email: Observable<String>
    
    init() {
        let fetching = BehaviorSubject<User>(value: Dummy.mingyu)
        
        fetchUser = fetching.asObserver()
        
        name = fetching
            .map { $0.name }
        
        
        email = fetching
            .map { $0.email }
    }
}
