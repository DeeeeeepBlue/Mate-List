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
    
    // TODO: User에 있는 Scrap Post 가져와서 Post DB에 for문 돌력서 있는지 확인하고 없으면 User에서 지우기

}
