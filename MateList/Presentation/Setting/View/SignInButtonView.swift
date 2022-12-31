//
//  SignInButtonView.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

import SnapKit
import GoogleSignIn
import AuthenticationServices

final class SignInButtonView: BaseView {
    
    private(set) lazy var googleButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.colorScheme = .light
        button.style = .wide
        return button
    }()
    
    private(set) lazy var authorizationButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        
        return button
    }()
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        self.addSubview(authorizationButton)
        self.addSubview(googleButton)
        
        authorizationButton.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(authorizationButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(30)
        }
    }
    
    override func bind() {
        print()
    }
}
