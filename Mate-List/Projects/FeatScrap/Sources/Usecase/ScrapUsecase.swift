//
//  ScrapUsecase.swift
//  FeatScrap
//
//  Created by 강민규 on 2023/03/12.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import RxSwift

import Service

class ScrapUsecase {
    // Properties
    var scrapPosts = BehaviorSubject<[Post]>(value: [])
    var posts: [Post] = []
    
    func fetchScrapPost() -> Observable<[Post]> {
        
        return Observable.create { observer in
            observer.onNext([])
            
            return Disposables.create()
        }
    }
}
