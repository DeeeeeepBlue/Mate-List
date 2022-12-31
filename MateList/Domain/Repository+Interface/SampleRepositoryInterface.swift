//
//  SampleRepositoryInterface.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/09.
//

import Foundation

class Dummy {
    let mingyu: User = User(
        uid: "2019010869",
        email: "mgo8434kk@gmail.com",
        name: "강민규",
        gender: "남",
        age: "23",
        habit: HabitCheck(
            cleanSelect: "매일",
            smokingSelect: false,
            gameSelect: false,
            snoringSelect: false,
            griding_teethSelect: false,
            callSelect: false,
            eatSelect: false,
            curfewSelect: false,
            bedtimeSelect: false,
            mbtiSelect: "ISTJ"
        )
    )
}
