//
//  HabitCheck.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/18.
//

import Foundation

public struct HabitCheck: Codable {
    let cleanSelect : String?
    let smokingSelect : Bool?
    let gameSelect : Bool?
    let snoringSelect : Bool?
    let griding_teethSelect : Bool?
    let callSelect : Bool?
    let eatSelect : Bool?
    let curfewSelect : Bool?
    let bedtimeSelect : Bool?
    let mbtiSelect : String?


    enum CodingKeys: String,CodingKey {
        case cleanSelect
        case smokingSelect
        case gameSelect
        case snoringSelect
        case griding_teethSelect
        case callSelect
        case eatSelect
        case curfewSelect
        case bedtimeSelect
        case mbtiSelect
    }
    
    func calculatingFit(otherSurvey: HabitCheck) -> Int?{
        var cnt = 0
        
        if otherSurvey.cleanSelect == self.cleanSelect { cnt += 1 }
        if otherSurvey.smokingSelect == self.smokingSelect { cnt += 1 }
        if otherSurvey.gameSelect == self.gameSelect { cnt += 1 }
        if otherSurvey.snoringSelect == self.snoringSelect { cnt += 1 }
        if otherSurvey.griding_teethSelect == self.griding_teethSelect { cnt += 1 }
        if otherSurvey.callSelect == self.callSelect { cnt += 1 }
        if otherSurvey.eatSelect == self.eatSelect { cnt += 1 }
        if otherSurvey.curfewSelect == self.curfewSelect { cnt += 1 }
        if otherSurvey.bedtimeSelect == self.bedtimeSelect { cnt += 1 }
        if otherSurvey.mbtiSelect == self.mbtiSelect { cnt += 1 }

        return Int(cnt / checkMate.select.count * 100)
    }

}

let select: [String: Any] = [
    "cleanSelect" : cleanSelect,
    "smokingSelect" : smokingSelect,
    "gameSelect" : gameSelect,
    "snoringSelect" : snoringSelect,
    "griding_teethSelect" : griding_teethSelect,
    "callSelect" : callSelect,
    "eatSelect" : eatSelect,
    "curfewSelect" : curfewSelect,
    "bedtimeSelect" : bedtimeSelect,
    "mbtiSelect" : mbtiSelect
]

var userHabitCheck: [HabitCheck] = []
