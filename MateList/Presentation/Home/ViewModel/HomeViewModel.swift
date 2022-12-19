//
//  HomeViewModel.swift
//  MateList
//
//  Created by 강민규 on 2022/12/13.
//

import UIKit

import RxSwift
import RxCocoa

protocol HomeViewModelType {
    var appear: AnyObserver<Void> { get }
    
    var allPosts: Observable<[Post]> { get }
    var matchPercent: Observable<String> { get }
}

class HomeViewModel: HomeViewModelType {
    let disposeBag = DisposeBag()
    
    //MARK: - 실제 사용될 Input
    var appear: AnyObserver<Void>

    //MARK: - 실제 사용될 Output
    var allPosts: Observable<[Post]>
    var matchPercent: Observable<String>
    
    //MARK: - Init
    init(homeUseCase: HomeDefaultUseCaseProtocol) {
        let viewAppear = PublishSubject<Void>()
        
        let posts = BehaviorSubject<[Post]>(value: [])
        let percent = BehaviorSubject<String>(value: "로그인 필요")

        appear = viewAppear.asObserver()
        
        viewAppear
            .flatMap(homeUseCase.posts)
            .map{ $0.map{ Post(uid: $0.uid, author: $0.author, title: $0.title, contents: $0.contents, isScrap: $0.isScrap, date: $0.date, pid: $0.pid) } }
            .subscribe(onNext: posts.onNext)
            .disposed(by: disposeBag)
        
        allPosts = posts
        
        matchPercent = percent
    }
}
