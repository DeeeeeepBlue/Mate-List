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
    
    var fetchList: AnyObserver<Void> { get }
    
    var posts: Observable<[Post]> { get }
}

class HomeViewModel: HomeViewModelType {
    let disposeBag = DisposeBag()
    
    //MARK: - 실제 사용될 Input
    var fetchList: AnyObserver<Void>
    
    
    //MARK: - 실제 사용될 Output
    var posts: Observable<[Post]>

    
    //MARK: - Init
    init(firebaseNetwork: Fetchable = FirebaseNetwork()) {
        // Subject
        let fetching = PublishSubject<Void>()
        
        let fetchPost = BehaviorSubject<[Post]>(value: [])
        
        // INPUT
        fetchList = fetching.asObserver()
        
        fetching
            .flatMap(firebaseNetwork.posts)
            .subscribe(onNext: fetchPost.onNext)
            .disposed(by: disposeBag)
            
        // OUTPUT
        posts = fetchPost
        
    }
}
