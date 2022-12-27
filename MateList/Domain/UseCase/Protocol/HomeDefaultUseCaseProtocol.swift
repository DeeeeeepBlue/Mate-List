//
//  HomeDefaultUseCaseProtocol.swift
//  MateList
//
//  Created by 강민규 on 2022/12/18.
//

import RxSwift

protocol HomeDefaultUseCaseProtocol {
    func posts() -> Observable<[Post]>
}