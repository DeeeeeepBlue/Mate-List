//
//  SurveyViewModel.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/10.
//

import Foundation
import RxSwift

class SurveyViewModel {
    let questions: Observable<[SurveyQuestionType]> = Observable.just(SurveyQuestionType.allCases)
    
    let answers: Observable<[Bool]> = Observable.just(Array(repeating: false, count: SurveyQuestionType.allCases.count))
    
    init(){
        bind()
    }
    
    func bind(){
        
    }
    
}



