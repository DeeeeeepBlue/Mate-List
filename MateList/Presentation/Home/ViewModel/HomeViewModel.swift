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
    var fetchMySurvey: AnyObserver<Void> { get }
    var fetchOtherSurvey: AnyObserver<Void> { get }
    
    var allPosts: Observable<[Post]> { get }
    var mySurvey: Observable<HabitCheck> { get }
    var otherSurveys: Observable<[String:HabitCheck]> { get }
}

class HomeViewModel: HomeViewModelType {
    let disposeBag = DisposeBag()
    
    //MARK: - 실제 사용될 Input
    var fetchList: AnyObserver<Void>
    var fetchMySurvey: AnyObserver<Void>
    var fetchOtherSurvey: AnyObserver<Void>
    
    
    //MARK: - 실제 사용될 Output
    var allPosts: Observable<[Post]>
    var mySurvey: Observable<HabitCheck>
    var otherSurveys: Observable<[String:HabitCheck]>
    
    //MARK: - Init
    init(firebaseNetwork: Fetchable = FirebaseNetwork()) {
        // Subject
        let fetchingPost = PublishSubject<Void>()
        let fetchingMySurvey = PublishSubject<Void>()
        let fetchingOtherSurvey = PublishSubject<Void>()
        
        let posts = BehaviorSubject<[Post]>(value: [])
        let myHabitSurvey = BehaviorSubject<HabitCheck>(value: HabitCheck(cleanSelect: "nil", smokingSelect: false, gameSelect: false, snoringSelect: false, griding_teethSelect: false, callSelect: false, eatSelect: false, curfewSelect: false, bedtimeSelect: false, mbtiSelect: "nil"))
        let otherHabitSurveys = BehaviorSubject<[String:HabitCheck]>(value: [:])
        
        // INPUT
        fetchList = fetchingPost.asObserver()
        
        fetchingPost
            .flatMap(firebaseNetwork.fetchPosts)
            .map{ $0.map{ Post(uid: $0.uid, author: $0.author, title: $0.title, contents: $0.contents, isScrap: $0.isScrap, date: $0.date, pid: $0.pid) } }
            .subscribe(onNext: posts.onNext)
            .disposed(by: disposeBag)
        
        fetchMySurvey = fetchingMySurvey.asObserver()
        
        fetchingMySurvey
        
        fetchOtherSurvey = fetchingOtherSurvey.asObserver()
            
        // OUTPUT
        allPosts = posts
        
        mySurvey = myHabitSurvey
        
        otherSurveys = otherHabitSurveys
        
    }
}
