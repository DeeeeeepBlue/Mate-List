//
//  TabBarPage.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/18.
//

public enum TabBarItemType: String, CaseIterable {
    case home, scrap, info
    
    public init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .scrap
        case 2: self = .info
        default: return nil
        }
    }
    
    /// TabBarPage 형을 매칭되는 Int형으로 반환
    public func toInt() -> Int {
        switch self {
        case .home: return 0
        case .scrap: return 1
        case .info: return 2
        }
    }
    
    /// TabBarPage 형을 매칭되는 한글명으로 변환
    public func toKrName() -> String {
        switch self {
        case .home: return "홈"
        case .scrap: return "스크랩"
        case .info: return "내정보"
        }
    }
    
    public func toIconName() -> String {
        switch self {
        case .home: return "house"
        case .scrap: return "star"
        case .info: return "person"
        }
    }
}
