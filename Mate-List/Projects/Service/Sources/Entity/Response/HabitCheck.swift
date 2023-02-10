//
//  HabitCheck.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/18.
//

import Foundation

public struct HabitCheck: Codable {
    public let cleanSelect : String
    public let smokingSelect : Bool
    public let gameSelect : Bool
    public let snoringSelect : Bool
    public let griding_teethSelect : Bool
    public let callSelect : Bool
    public let eatSelect : Bool
    public let curfewSelect : Bool
    public let bedtimeSelect : Bool
    public let mbtiSelect : String

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
    
    public init(cleanSelect: String, smokingSelect: Bool, gameSelect: Bool, snoringSelect: Bool, griding_teethSelect: Bool, callSelect: Bool, eatSelect: Bool, curfewSelect: Bool, bedtimeSelect: Bool, mbtiSelect: String) {
        self.cleanSelect = cleanSelect
        self.smokingSelect = smokingSelect
        self.gameSelect = gameSelect
        self.snoringSelect = snoringSelect
        self.griding_teethSelect = griding_teethSelect
        self.callSelect = callSelect
        self.eatSelect = eatSelect
        self.curfewSelect = curfewSelect
        self.bedtimeSelect = bedtimeSelect
        self.mbtiSelect = mbtiSelect
    }
}


