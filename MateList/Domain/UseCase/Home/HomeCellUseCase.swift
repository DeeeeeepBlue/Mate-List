//
//  HomeTableViewCellUseCase.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import Foundation

import RxSwift

class HomeCellUseCase: HomeCellUseCaseProtocol {
    //MARK: - 적합도 계산
    static func calculatingFit(mySurvey: HabitCheck, otherSurvey: HabitCheck) -> Observable<Int> {
        var cnt = 0
        let selectCnt = 10
        var myHabit: HabitCheck?
        var otherHabit: HabitCheck?
        
        myHabit = mySurvey
        otherHabit = otherSurvey
    
        return Observable.create { observer in
            
            
            if otherHabit?.cleanSelect == myHabit?.cleanSelect { cnt += 1 }
            if otherHabit?.smokingSelect == myHabit?.smokingSelect { cnt += 1 }
            if otherHabit?.gameSelect == myHabit?.gameSelect { cnt += 1 }
            if otherHabit?.snoringSelect == myHabit?.snoringSelect { cnt += 1 }
            if otherHabit?.griding_teethSelect == myHabit?.griding_teethSelect { cnt += 1 }
            if otherHabit?.callSelect == myHabit?.callSelect { cnt += 1 }
            if otherHabit?.eatSelect == myHabit?.eatSelect { cnt += 1 }
            if otherHabit?.curfewSelect == myHabit?.curfewSelect { cnt += 1 }
            if otherHabit?.bedtimeSelect == myHabit?.bedtimeSelect { cnt += 1 }
            if otherHabit?.mbtiSelect == myHabit?.mbtiSelect { cnt += 1 }
            
            let result = Int(Double(cnt) / Double(selectCnt) * 100)
            
            observer.onNext(result)
            return Disposables.create()
        }
    }
}
