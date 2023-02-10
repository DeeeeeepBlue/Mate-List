//
//  Post.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/18.
//

import Foundation

public struct Post: Codable {
    public let pid : String
    public let uid : String
    public let title: String
    public let contents: String
    public let date : String
    public let isScrap : Bool
    public let findMate: Bool
    
    public init(pid: String, uid: String, title: String, contents: String, date: String, isScrap: Bool, findMate: Bool) {
        self.pid = pid
        self.uid = uid
        self.title = title
        self.contents = contents
        self.date = date
        self.isScrap = isScrap
        self.findMate = findMate
    }
}
