//
//  QuitButtonViewModel.swift
//  MateList
//
//  Created by 강민규 on 2023/01/04.
//

import RxSwift
import FirebaseAuth

protocol QuitButtonViewModelProtocol {
    var tapButton: AnyObserver<Void> { get }
}

class QuitButtonViewModel: QuitButtonViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let idRepository = IDFirestoreRepository()
    private let settingRepository = SettingRepository()
    var tapButton: AnyObserver<Void>
    
    
    init() {
        let tapping = PublishSubject<Void>()
        
        let userData = BehaviorSubject<AuthDataResult?>(value: nil)
        
        tapButton = tapping.asObserver()
        
        tapping
            .flatMap{AppDelegate.userAuth}
            .bind(onNext: userData.onNext)
            .disposed(by: disposeBag)
        
        userData
            .subscribe(onNext: { data in
                guard let uid = data?.user.uid else { return }
                
                self.idRepository.deleteAllHabit(uid: uid)
                self.idRepository.deleteAllPost(uid: uid)
                self.idRepository.deleteAllScrap(uid: uid)
                self.idRepository.deleteUser(uid: uid)
                
                self.settingRepository.authSignOut()
            })
            .disposed(by: disposeBag)
                       
        
    }
}
