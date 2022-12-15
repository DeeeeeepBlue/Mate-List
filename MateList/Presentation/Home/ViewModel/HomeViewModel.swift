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
    
    var allPosts: Observable<[Post]> { get }
}

class HomeViewModel: HomeViewModelType {
    let disposeBag = DisposeBag()
    
    //MARK: - 실제 사용될 Input
    var fetchList: AnyObserver<Void>
    
    //MARK: - 실제 사용될 Output
    var allPosts: Observable<[Post]>
    
    //MARK: - Init
    init(firebaseNetwork: Fetchable = FirebaseNetwork()) {
        // Subject
        let fetching = PublishSubject<Void>()
        
        let posts = BehaviorSubject<[Post]>(value: [])
        
        // INPUT
        fetchList = fetching.asObserver()
        
        fetching
            .flatMap(firebaseNetwork.fetchPosts)
            .map{ $0.map{ Post(uid: $0.uid, author: $0.author, title: $0.title, contents: $0.contents, isScrap: $0.isScrap, date: $0.date, pid: $0.pid) } }
            .subscribe(onNext: posts.onNext)
            .disposed(by: disposeBag)
            
        // OUTPUT
        allPosts = posts.asObserver()
        
    }
}
