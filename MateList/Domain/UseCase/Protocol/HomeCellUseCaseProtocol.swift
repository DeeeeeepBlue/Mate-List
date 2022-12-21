//
//  HomeCellUseCaseProtocol.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import RxSwift

protocol HomeCellUseCaseProtocol{
    static func calculatingFit(mySurvey: HabitCheck, otherSurvey: HabitCheck) -> Observable<Int>
}
