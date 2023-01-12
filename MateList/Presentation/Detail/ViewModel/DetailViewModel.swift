//
//  DetailViewModel.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import Foundation

import RxSwift

class DetailViewModel {
    private var disposeBag = DisposeBag()
    private let detailUseCase: DefaultDetailUseCase
    
    init(detailUseCase: DefaultDetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    struct Input {
        var appear: Observable<Void>
    }
    
    struct Output {
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
        
        return output
    }
}
