//
//  SurveyQuestion.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/10.
//

import Foundation

public enum SurveyQuestionType: CaseIterable {
    case smoking,
         cleaning,
         game,
         snoring,
         teethGrinding,
         phoneCallInRoom,
         eatingInRoom,
         showerTime,
         lateReturnRoom
    
    public func toKrQuestion() -> String{
        switch self {
        case .smoking:
            return "흡연을 하시나요?"
        case .cleaning:
            return "청소는 얼마에 한번씩 하시나요?"
        case .game:
            return "게임을 하시나요?"
        case .snoring:
            return "코를 고나요?"
        case .teethGrinding:
            return "이를 가나요?"
        case .phoneCallInRoom:
            return "방 안에서 통화를 하나요?"
        case .eatingInRoom:
            return "방 안에서 음식을 먹나요?"
        case .showerTime:
            return "아침에 샤워를 하시나요, 저녁에 샤워를 하시나요?"
        case .lateReturnRoom:
            return "주로 12시 이후에 귀가하시나요?"
        }
    }
}
