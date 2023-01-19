//
//  DetailRepositoryProtocol.swift
//  MateList
//
//  Created by 강민규 on 2023/01/18.
//

import Foundation

import RxSwift

protocol DetailRepositoryProtocol {
    func fetchComments(pid: String) -> Observable<[String:Any]>
    func deletePost(pid: String)
    func deleteComment(pid: String, cid: String)
    func isScrap(uid: String, pid: String) -> Observable<Bool> 
}
