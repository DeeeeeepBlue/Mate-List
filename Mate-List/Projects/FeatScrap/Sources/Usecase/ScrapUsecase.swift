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
    var repository = ScrapRepository()
    var disposeBag = DisposeBag()
    
    /// 스크랩된 포스트를 가져오는 변수
    var scrapPosts = BehaviorSubject<[Post]>(value: [])
    
    
    var posts: [Post] = []
  
    
    // TODO: User에 있는 Scrap Post 가져와서 Post DB에 for문 돌력서 있는지 확인하고 없으면 User에서 지우기
    func fetchScrapPost(uid: String) -> Observable<[Post]> {
        return Observable.create { observer in
            
            self.repository.fetchScrapPosts(uid: uid)
                .subscribe(onNext: { scrapPosts in
                    self.posts = scrapPosts
                    observer.onNext(self.posts)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
            
        }
    }
    
    func getUID() -> Observable<String> {
        return IDFirestoreRepository.myUID()
    }
}