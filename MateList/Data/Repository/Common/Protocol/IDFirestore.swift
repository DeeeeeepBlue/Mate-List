//
//  IDFirestore.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//

import RxSwift

protocol IDFirestore {
    func userName(uid: String) -> Observable<String>
}
