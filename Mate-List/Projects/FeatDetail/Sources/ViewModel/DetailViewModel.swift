//
//  DetailViewModel.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import Foundation

import RxSwift

import Network

class DetailViewModel {
    private var disposeBag = DisposeBag()
    private let detailUseCase: DefaultDetailUseCase
    
    init(detailUseCase: DefaultDetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    struct Input {
        var appear: Observable<Void>
        var tapScrap: Observable<Void>
    }
    
    struct Output {
        var allComments = BehaviorSubject<[Comment]>(value: [])
        
        var scrapFill = PublishSubject<Bool>()
        var userText = BehaviorSubject<String>(value: "작성자")
        var titleText = BehaviorSubject<String>(value: "제목")
        var contentsText = BehaviorSubject<String>(value: "내용")
        var dateText = BehaviorSubject<String>(value: "작성날짜")
    }
    
    func transform(from input: Input) -> Output {
        configureInput(input)
        return createOutput(from: input)
    }
    
    func configureInput(_ input: Input) {
        input.appear
            .flatMap(detailUseCase.fetchUserName)
            .subscribe(onNext: self.detailUseCase.userName.onNext)
            .disposed(by: disposeBag)
        
        input.appear
            .flatMap { _ in
                let pid = self.detailUseCase.pid()
                return self.detailUseCase.fetchComments(pid: pid)
            }
            .subscribe(onNext: self.detailUseCase.allComments.onNext)
            .disposed(by: disposeBag)
            
        input.appear
            .flatMap(detailUseCase.isScrap)
            .subscribe(onNext: self.detailUseCase.scrapState.onNext)
            .disposed(by: disposeBag)
            
        // 탭 발생 시 onNext 실행
        input.tapScrap
            .flatMap(detailUseCase.isScrap)
            .map{ isScrap in
                self.detailUseCase.scrapDataSetting(scraped: isScrap)
                return !isScrap
            }
            .subscribe(onNext: self.detailUseCase.scrapState.onNext)
            .disposed(by: disposeBag)
        
    }
    
    func createOutput(from: Input) -> Output {
        var output = Output()
        
        detailUseCase.userName
            .subscribe(onNext: { str in
                output.userText.onNext(str)
            })
            .disposed(by: disposeBag)
        
        detailUseCase.fetchPostData()
            .subscribe(onNext: { post in
                output.titleText.onNext(post.title)
                output.dateText.onNext(post.date)
                output.contentsText.onNext(post.contents)
            })
            .disposed(by: disposeBag)
        
        detailUseCase.scrapState
            .subscribe(onNext: { bool in
                output.scrapFill.onNext(bool)
            })
            .disposed(by: disposeBag)
        
        output.allComments = self.detailUseCase.allComments
        
        return output
    }
    
    func reportPostUser() {
        detailUseCase.reportPostUser()
    }
    
    func reportUser(uid: String) {
        detailUseCase.reportUser(reportUid: uid)
    }
    
    func deleteComment(pid: String, cid: String) {
        detailUseCase.deleteComment(pid: pid, cid: cid)
    }
    
    func deletePost() {
        detailUseCase.deletePost()
    }

}
