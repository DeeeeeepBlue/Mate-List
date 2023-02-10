//
//  DetailUseCase.swift
//  MateList
//
//  Created by 강민규 on 202gi3/01/10.
//

import Foundation

import RxSwift
import UIKit

import Service

class DefaultDetailUseCase {
    //MARK: 프로퍼티
    var disposeBag = DisposeBag()
    private var post: Post
    var detailRepository: DetailRepository
    
    var scrapState = PublishSubject<Bool>()
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
    
    
    func reportPostUser() {
        var myUid: String
        var reportUid: String
        
        myUid = IDFirestoreRepository.myUIDString()
        reportUid = post.uid
        
        IDFirestoreRepository.reportUser(myUid: myUid, reportUid: reportUid)
    }
    
    func reportUser(reportUid: String) {
        var myUid: String
        
        myUid = IDFirestoreRepository.myUIDString()
        
        IDFirestoreRepository.reportUser(myUid: myUid, reportUid: reportUid)
    }
    
    func deletePost() {
        detailRepository.deletePost(pid: post.pid)
    }
    
    func deleteComment(pid: String, cid: String) {
        detailRepository.deleteComment(pid: pid, cid: cid)
    }
    
    
    
    func scrapDataSetting(scraped: Bool) {
        let uid = IDFirestoreRepository.myUIDString()
        let pid = post.pid
        // 현재 유저가 스크랩 했는가?
        if scraped {
            // 스크랩을 삭제한다.
            self.detailRepository.deleteScrap(uid: uid, pid: pid)
        }
        else {
            // 스크랩을 추가한다.
            self.detailRepository.registerScrap(uid: uid ,pid: pid, post: self.post)
        }
    }
    
    func isScrap() -> Observable<Bool> {
        let myUID = IDFirestoreRepository.myUIDString()
        return detailRepository.isScrap(uid: myUID, pid: post.pid)
            
    }
    
    func pid() -> String {
        return post.pid
    }
    
    static func getUserName(uid: String) -> Observable<String> {
        return IDFirestoreRepository
            .userName(uid: uid)
    }
}
