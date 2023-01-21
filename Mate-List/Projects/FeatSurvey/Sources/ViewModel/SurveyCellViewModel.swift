//
//  SurveyCellViewModel.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/10.
//

import RxSwift

class SurveyCellViewModel {
    var question: PublishSubject<String>
    var questionNumber: PublishSubject<Int>
    
    init() {
        self.question = PublishSubject()
        self.questionNumber = PublishSubject()
    }
}
