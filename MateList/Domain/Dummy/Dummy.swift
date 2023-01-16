//
//  Dummy.swift
//  MateList
//
//  Created by 강민규 on 2022/12/31.
//

import Foundation

class Dummy {
    static let mingyu: User = User(
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
    
    static let dummyPost: Post = Post(pid: "Pid",
                                      uid: "Uid",
                                      title: "룸메이트 구합니다.",
                                      contents: "룸메이트 구해요~",
                                      date: "2022/01/01",
                                      isScrap: false,
                                      findMate: false
                                    )
}
