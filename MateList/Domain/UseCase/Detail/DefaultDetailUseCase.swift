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
    var detailRepository: DetailRepository
    
    var allComments = BehaviorSubject<[Comment]>(value: [])
    var userName = PublishSubject<String>()
    var commentsItems: [Comment] = []
    
    init(post: Post, detailRepository: DetailRepository) {
        self.post = post
        self.detailRepository = detailRepository
    }
    
    func fetchComments(pid: String) -> Observable<[Comment]> {
        var uid: String = "initID"
        var cid: String = "initCID"
        var contents: String = "initContents"
        var date: String = "initDate"
    
        return Observable.create { observer in
            self.detailRepository.fetchComments(pid: pid)
                .subscribe(onNext: { data in
                    cid = data["cid"] as? String ?? "noCID"
                    uid = data["uid"] as? String ?? "noID"
                    //TODO: Reply -> Contents로 수정하는게 어떨까
                    contents = data["reply"] as? String ?? "noContent"
                    date = data["date"] as? String ?? "noDate"
                    
                    
                    self.commentsItems.append(Comment(uid: uid, pid: pid, cid: cid, contents: contents, date: date))
                    print(self.commentsItems)
                    observer.onNext(self.commentsItems)
                })
                .disposed(by: self.disposeBag)

            return Disposables.create()
        }
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
    
    func pid() -> String {
        return post.pid
    }
}
