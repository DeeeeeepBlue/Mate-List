//
//  DetailUseCase.swift
//  MateList
//
//  Created by 강민규 on 202gi3/01/10.
//

import Foundation

import RxSwift

class DefaultDetailUseCase {
    var disposeBag = DisposeBag()
    private var post: Post
    
    
    var userName = PublishSubject<String>()
    
    init(post: Post) {
        self.post = post
    }

    func fetchUserName() -> Observable<String>{
        let userUID = self.post.uid
        let userName = IDFirestoreRepository.userName(uid: userUID)
        return userName
    }
    
    func fetchPostData() -> Observable<Post> {
        return Observable.create { observer in
            observer.onNext(self.post)
            
            return Disposables.create()
        }
    }
}
