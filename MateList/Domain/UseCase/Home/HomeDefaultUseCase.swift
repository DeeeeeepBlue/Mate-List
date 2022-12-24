//
//  HomeDefaultUseCase.swift
//  MateList
//
//  Created by 강민규 on 2022/12/18.
//
//
//


import RxSwift

// MARK: - Private

class HomeDefaultUseCase: HomeDefaultUseCaseProtocol {
    let disposeBag: DisposeBag = DisposeBag()
    let firestoreRepository : DefaultFirestoreRepository

    init(firestoreRepository: DefaultFirestoreRepository) {
        self.firestoreRepository = firestoreRepository

    }
    
    func transPost() -> Observable<Post> {
        var pid: String = "initPid"
        var uid: String = "initID"
        var title: String = "initTitle"
        var contents: String = "initContents"
        var date: String = "initDate"
        var isScrap: Bool = false
        var findMate: Bool = false
        
        return Observable.create { observer in
            let data = self.firestoreRepository.fetchPost()
            
            data
                .subscribe(onNext: { data in
                    pid = data["pid"] as? String ?? "noPid"
                    uid = data["uid"] as? String ?? "noID"
                    title = data["title"] as? String ?? "noTitle"
                    contents = data["contents"] as? String ?? "noContent"
                    date = data["date"] as? String ?? "noDate"
                    isScrap = data["isScrap"] as? Bool ?? false
                    findMate = data["findMate"] as? Bool ?? false
                    
                   let post = Post(pid: pid, uid: uid, title: title, contents: contents, date: date, isScrap: isScrap, findMate: findMate)
                    
                    observer.onNext(post)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func posts() -> Observable<[Post]> {
        return Observable.create { observer in
            var items: [Post] = []
            self.transPost().subscribe { post in
                items.append(post)
                observer.onNext(items)
            }
            return Disposables.create()
        }
    }
}
