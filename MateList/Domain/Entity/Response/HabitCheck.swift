//
//  HabitCheck.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/18.
//

import Foundation

public struct HabitCheck: Codable {
    let cleanSelect : String
    let smokingSelect : Bool
    let gameSelect : Bool
    let snoringSelect : Bool
    let griding_teethSelect : Bool
    let callSelect : Bool
    let eatSelect : Bool
    let curfewSelect : Bool
    let bedtimeSelect : Bool
    let mbtiSelect : String

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
}


