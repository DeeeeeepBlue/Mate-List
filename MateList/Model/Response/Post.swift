//
//  Post.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/18.
//

import Foundation


public struct Post {
    var uid : String
    let author: String
    let title: String
    let contents: String
    var isScrap : Bool
    let date : String
    let pid : String
}

var currentData: Post!

