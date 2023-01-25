//
//  Comment.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/18.
//

import Foundation

public struct Comment {
    public let uid: String
    public let pid: String
    public let cid: String
    public let contents: String
    public let date : String
        
    public init(uid: String, pid: String, cid: String, contents: String, date: String) {
        self.uid = uid
        self.pid = pid
        self.cid = cid
        self.contents = contents
        self.date = date
    }
}
