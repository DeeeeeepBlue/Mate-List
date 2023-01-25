//
//  SettingRepositoryProtocol.swift
//  MateList
//
//  Created by 강민규 on 2023/01/02.
//

import FirebaseAuth

public protocol SettingRepositoryProtocol {
    //func googleCredential() -> AuthCredential
    //func appleCredential() -> AuthCredential
    func authSignIn(credential: AuthCredential)
    func authSignOut()
    func registUser(user: User)
}
