//
//  HomeTableVIewCellViewModel.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//



import RxSwift

import Network

protocol HomeCellViewModelProtocol {
    var post: AnyObserver<Post> { get }
    
    var matchPercent: Observable<String> { get }
    var title: Observable<String> { get }
    var contents: Observable<String> { get }
    var date: Observable<String> { get }
    var user: Observable<String> { get }
}

class HomeCellViewModel: HomeCellViewModelProtocol {
    var disposeBag = DisposeBag()
    
    var post: AnyObserver<Post>
    
    var matchPercent: Observable<String>
    var title: Observable<String>
    var contents: Observable<String>
    var date: Observable<String>
    var user: Observable<String>
    
    init() {
        let postSubject = PublishSubject<Post>()

        let myHabit: Observable<HabitCheck>
        let otherHabit: Observable<HabitCheck>
        
        
        
        myHabit = HomeCellUseCase
            .getMyUID()
            .flatMap{ HomeCellUseCase.getHabitCheck(uid: $0) }
            
        otherHabit = postSubject
            .map{ $0.uid }
            .flatMap{ HomeCellUseCase.getHabitCheck(uid: $0)}

        // ???: 이상한 셀에 적합도를 넣어줌.
        matchPercent = Observable
            .zip(myHabit, otherHabit,resultSelector: { myHabit, otherHabit in
                return HomeCellUseCase.calculatingFit(mySurvey: myHabit, otherSurvey: otherHabit)
            })
            .map{"\($0)%"}
            .debug()
            
        post = postSubject.asObserver()
         
        title = postSubject
            .map{ $0.title }
        
        contents = postSubject
            .map{ $0.contents }
        
        date = postSubject
            .map{ $0.date }
        
        // ???: 이름이 왔다갔다하는 버그 있음
        user = postSubject
            .map{ $0.uid }
            .flatMap{HomeCellUseCase.getUserName(uid: $0)}
        
    }
}
