//
//  SurveyCellViewModel.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/10.
//

import RxSwift

class SurveyCellViewModel {
    var question: PublishSubject<String>
    
    init() {
        self.question = PublishSubject()
    }
}
