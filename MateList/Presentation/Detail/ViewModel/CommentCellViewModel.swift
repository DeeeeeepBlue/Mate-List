//
//  CommentCellViewModel.swift
//  MateList
//
//  Created by 강민규 on 2023/01/10.
//

import Foundation

import RxSwift

protocol CommentCellViewModelProtocol {
    var comment: AnyObserver<Comment> { get }
    
    var contents: Observable<String> { get }
    var date: Observable<String> { get }
    var user: Observable<String> { get }
}

class CommentCellViewModel: CommentCellViewModelProtocol {
    
    var comment: AnyObserver<Comment>
    
    var contents: Observable<String>
    var date: Observable<String>
    var user: Observable<String>
    
    init() {
        let commentSubject = PublishSubject<Comment>()
        
        comment = commentSubject.asObserver()
        
        contents = commentSubject
            .map{ $0.contents }
        
        date = commentSubject
            .map { $0.date }
        
        user = commentSubject
            .map { $0.uid }
            .flatMap { IDFirestoreUseCase.getUserName(uid: $0)}
        
    }
    
}
