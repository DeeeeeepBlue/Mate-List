//
//  HomeCellUseCaseProtocol.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import RxSwift

import Network

protocol HomeCellUseCaseProtocol{
    static func getUserName(uid: String) -> Observable<String>
    static func getHabitCheck(uid: String) -> Observable<HabitCheck>
    static func getMyUID() -> Observable<String>
    static func calculatingFit(mySurvey: HabitCheck, otherSurvey: HabitCheck) -> Int
}
