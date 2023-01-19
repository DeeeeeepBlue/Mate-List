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
    var disposeBag: DisposeBag = DisposeBag()
    let firestoreRepository : DefaultFirestoreRepository

    var allPosts = BehaviorSubject<[Post]>(value: [])
    var items: [Post] = []
    
    init(firestoreRepository: DefaultFirestoreRepository) {
        self.firestoreRepository = firestoreRepository

    }
    
    func posts() -> Observable<[Post]> {
        var pid: String = "initPid"
        var uid: String = "initID"
        var user: String = "initUser"
        var title: String = "initTitle"
        var contents: String = "initContents"
        var date: String = "initDate"
        var isScrap: Bool = false
        var findMate: Bool = false
        
        itemsClear()
        
        return Observable.create { observer in
            let data = self.firestoreRepository.fetchPosts()
            data
                .subscribe(onNext: { data in
                    pid = data["pid"] as? String ?? "noPid"
                    uid = data["uid"] as? String ?? "noID"
                    user = data["user"] as? String ?? "noUser"
                    title = data["title"] as? String ?? "noTitle"
                    contents = data["contents"] as? String ?? "noContent"
                    date = data["date"] as? String ?? "noDate"
                    isScrap = data["isScrap"] as? Bool ?? false
                    findMate = data["findMate"] as? Bool ?? false
                    
                    self.items.append(Post(pid: pid, uid: uid, title: title, contents: contents, date: date, isScrap: isScrap, findMate: findMate))
                    observer.onNext(self.items)
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func itemsClear() {
        items = []
    }
}
