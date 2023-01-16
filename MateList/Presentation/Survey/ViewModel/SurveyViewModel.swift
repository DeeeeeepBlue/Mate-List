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
    
    init(){
        bind()
    }
    
    func bind(){
        
    }
    
}



