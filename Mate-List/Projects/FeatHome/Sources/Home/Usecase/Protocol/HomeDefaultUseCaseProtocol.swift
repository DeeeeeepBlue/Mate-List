//
//  HomeDefaultUseCaseProtocol.swift
//  MateList
//
//  Created by 강민규 on 2022/12/18.
//

import RxSwift

import Network

public protocol HomeDefaultUseCaseProtocol {
    func posts() -> Observable<[Post]>
    var allPosts: BehaviorSubject<[Post]> { get }
    var items: [Post] { get }
}
