//
//  ScrapViewModel.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/29.
//
import UIKit

import RxSwift
import RxCocoa

import Service

class ScrapViewModel {
    // Properties
    let disposeBag = DisposeBag()
    private weak var coordinator: DefaultScrapCoordinator?
    private let scrapUsecase: ScrapUsecase
    
    // Input
    struct Input {
        var appear: Observable<Void>
        var cellTapEvent: Observable<IndexPath>
    }
    
    // Output
    struct Output {
        var allPosts = BehaviorSubject<[Post]>(value: [])
    }
    
    // Init
    init(coordinator: DefaultScrapCoordinator, scrapUsecase: ScrapUsecase) {
        self.coordinator = coordinator
        self.scrapUsecase = scrapUsecase
    }
    
    // Function: Make Input, Output
    func configureinput(_ input: Input) {
        input.appear
            .flatMap(scrapUsecase.fetchScrapPost)
            .subscribe(onNext: self.scrapUsecase.scrapPosts.onNext)
            .disposed(by: disposeBag)
        
        input.cellTapEvent
            .subscribe(onNext: { indexPath in
                let post = self.scrapUsecase.posts[indexPath.row]
                //self.coordinator?.showDetailFlow(postData: post)
            })
            .disposed(by: disposeBag)
    }
    
    func createOutput(_ input: Input) -> Output {
        var output = Output()
        
        output.allPosts = self.scrapUsecase.scrapPosts
        
        return output
    }
    
    // Function: Transform
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureinput(input)
        return createOutput(input)
    }
}
