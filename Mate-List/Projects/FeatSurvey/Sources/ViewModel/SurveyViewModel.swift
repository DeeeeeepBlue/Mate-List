//
//  SurveyViewModel.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/10.
//

import Foundation
import Utility
import Service
import RxSwift
import RxCocoa


/// ⚙️ 설계: SurveyViewModel의 역할
/// 1. 설문 결과 (ture/false Array)를 받아서 HabitCheck으로 변환한 뒤 서버에 전송하는 로직 호출
/// 2. 서버에 업로드한 결과를 반환
class SurveyViewModel {
    
    struct Input {
        let surveyResult: Signal<HabitCheck>
    }
    
    struct Output {
        let isSucess: Driver<Bool>
    }
    
    let questions: Observable<[SurveyQuestionType]> = Observable.just(SurveyQuestionType.allCases)
    
    let answers: Observable<[Bool]> = Observable.just(Array(repeating: false,
                                                            count: SurveyQuestionType.allCases.count))
    
    private let isSucess = BehaviorRelay<Bool>(value: false)
    
    init(){
    }
    
    func execute(input: Input) -> Output {
        
        
        return Output(isSucess: isSucess.asDriver())
    }
}
