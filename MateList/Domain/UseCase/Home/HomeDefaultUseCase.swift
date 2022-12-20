//
//  HomeDefaultUseCase.swift
//  MateList
//
//  Created by 강민규 on 2022/12/18.
//
//
//

//postItems.append(
//    Post(
//        uid: uid,
//        author: author,
//        title: title,
//        contents: content,
//        isScrap: isScrap,
//        date: date,
//        pid: pid
//    )
//)

import RxSwift

// MARK: - Private

class HomeDefaultUseCase: HomeDefaultUseCaseProtocol {
    let disposeBag: DisposeBag = DisposeBag()
    let firestoreRepository : DefaultFirestoreRepository

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
        
        return Observable.create { observer in
            let data = self.firestoreRepository.fetchPost()
            var items: [Post] = []
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
                    
                    items.append(Post(pid: pid, uid: uid, title: title, contents: contents, date: date, isScrap: isScrap, findMate: findMate))
                    observer.onNext(items)
                })
                .disposed(by: self.disposeBag)
            
           
            
            return Disposables.create()
        }
    }
    
    // 적합도 계산
    func calculatingFit(mySurvey: HabitCheck, otherSurvey: HabitCheck) -> Int{
        var cnt = 0
        
        var cleanSelect : String = ""
        var smokingSelect : Bool = false
        var gameSelect : Bool = false
        var snoringSelect : Bool = false
        var griding_teethSelect : Bool = false
        var callSelect : Bool = false
        var eatSelect : Bool = false
        var curfewSelect : Bool = false
        var bedtimeSelect : Bool = false
        var mbtiSelect : String = ""
        
        let select: [String: Any] = [
            "cleanSelect" : cleanSelect,
            "smokingSelect" : smokingSelect,
            "gameSelect" : gameSelect,
            "snoringSelect" : snoringSelect,
            "griding_teethSelect" : griding_teethSelect,
            "callSelect" : callSelect,
            "eatSelect" : eatSelect,
            "curfewSelect" : curfewSelect,
            "bedtimeSelect" : bedtimeSelect,
            "mbtiSelect" : mbtiSelect
        ]
        
        if otherSurvey.cleanSelect == mySurvey.cleanSelect { cnt += 1 }
        if otherSurvey.smokingSelect == mySurvey.smokingSelect { cnt += 1 }
        if otherSurvey.gameSelect == mySurvey.gameSelect { cnt += 1 }
        if otherSurvey.snoringSelect == mySurvey.snoringSelect { cnt += 1 }
        if otherSurvey.griding_teethSelect == mySurvey.griding_teethSelect { cnt += 1 }
        if otherSurvey.callSelect == mySurvey.callSelect { cnt += 1 }
        if otherSurvey.eatSelect == mySurvey.eatSelect { cnt += 1 }
        if otherSurvey.curfewSelect == mySurvey.curfewSelect { cnt += 1 }
        if otherSurvey.bedtimeSelect == mySurvey.bedtimeSelect { cnt += 1 }
        if otherSurvey.mbtiSelect == mySurvey.mbtiSelect { cnt += 1 }
        
        return Int(Double(cnt) / Double(select.count) * 100)
    }
}
