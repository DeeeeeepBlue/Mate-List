//
//  SettingRepository.swift
//  MateList
//
//  Created by 강민규 on 2023/01/02.
//

import FirebaseAuth

class SettingRepository: SettingRepositoryProtocol {
    /* TODO: SettingVC에 있는 SignIn 로직 리팩토링 고려
    ViewController 에 로그인 view를 띄우는데 View 구현이 안된 상태
    func googleCredential() -> AuthCredential {
        
    }
    
    func appleCredential() -> AuthCredential {
        
    }
     */
    
    func authSignIn(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase sign in error: \(error)")
                return
            } else {
                AppDelegate.userAuth = authResult
            }
        }
    }
    
    func registUser(user: User) {
        FireStoreService.db.collection("User").document(user.uid).setData([
            "user" : user.name,
            "email" : user.email,
            "gender" : user.gender,
            "uid" : user.uid,
            // TODO: 닉네임 대체방안 필요(모델 수정)
            "NickName" : user.name
        ])
    }
    
    
}
