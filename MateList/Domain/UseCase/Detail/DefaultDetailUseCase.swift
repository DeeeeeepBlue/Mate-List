//
//  DetailUseCase.swift
//  MateList
//
//  Created by 강민규 on 202gi3/01/10.
//

import Foundation

import RxSwift

class DefaultDetailUseCase {
    
    var post: Post
    var detailData = BehaviorSubject<Post>(value: Dummy.dummyPost)
    
    init(post: Post) {
        self.post = post
        printPost()
    }
    
    func printPost() {
        print(post)
    }
    
}
