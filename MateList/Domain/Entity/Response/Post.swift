//
//  Post.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/18.
//

import Foundation


public struct Post: Codable {
    let pid : String
    let uid : String
    let title: String
    let contents: String
    let date : String
    let isScrap : Bool
    let findMate: Bool
}
