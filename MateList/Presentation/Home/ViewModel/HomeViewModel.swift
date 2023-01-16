//
//  HomeViewModel.swift
//  MateList
//
//  Created by 강민규 on 2022/12/13.
//

import UIKit

import RxSwift
import RxCocoa

class HomeViewModel {
    
    let disposeBag = DisposeBag()
    private weak var coordinator: HomeCoordinator?
    private let homeUseCase: HomeDefaultUseCaseProtocol
    
    //MARK: - 실제 사용될 Input
    struct Input {
        var appear: Observable<Void>
        var cellTapEvent: Observable<IndexPath>
    }
    //MARK: - 실제 사용될 Output
    struct Output {
        var allPosts = BehaviorSubject<[Post]>(value: [])
    }
    //MARK: - Init
    init(coordinator: HomeCoordinator, homeUseCase: HomeDefaultUseCaseProtocol) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        self.configureInput(input)
        return createOutput(from: input)
    }
    
    func configureInput(_ input: Input) {
        input.appear
            .flatMap(homeUseCase.posts)
            .subscribe(onNext: self.homeUseCase.allPosts.onNext)
            .disposed(by: disposeBag)
        
        input.cellTapEvent
            .subscribe(onNext: { indexPath in
                let post = self.homeUseCase.items[indexPath.row]
                self.coordinator?.showDetailFlow(postData: post)
            })
            .disposed(by: disposeBag)
    }
    
    func createOutput(from input: Input) -> Output{
        var output = Output()
        
        output.allPosts = self.homeUseCase.allPosts
        
        return output
    }
}
