//
//  HomeTableVIewCellViewModel.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//



import RxSwift

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
        let postSubject = BehaviorSubject<Post>(value: Post(pid: "nil", uid: "nil", title: "nil", contents: "nil", date: "nil", isScrap: false, findMate: false))
        
        let myHabit: Observable<HabitCheck>
        let otherHabit: Observable<HabitCheck>
        
        // !!!: 사용하지 않은 Observable 소스
        myHabit = IDFirestoreUseCase
            .getMyUID()
            .flatMap{ IDFirestoreUseCase.getHabitCheck(uid: $0) }
            
        otherHabit = postSubject
            .map{ $0.uid }
            .flatMap{ IDFirestoreUseCase.getHabitCheck(uid: $0)}

        // FIXME: 퍼센트 로직 세우기
        matchPercent = postSubject
            .map{_ in "수정 필요"}
        
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
            .flatMap{IDFirestoreUseCase.getUserName(uid: $0)}
        
    }
}
