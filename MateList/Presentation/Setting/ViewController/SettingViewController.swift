//
//  SettingViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

import SnapKit
import RxSwift

class SettingViewController: BaseViewController {
    //MARK: - Properties
    private let myProfileView = MyProfileView()
    private let surveyButton = SurveyButton()
    private let questionButton = QuestionButton()
    private let signOutButton = SignOutButton()
    private let quitButton = QuitButton()
    private let signInButtonView = SignInButtonView()
    
    private let nickNameView = NickNameView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func style() {
        super.style()
        
        navigationController?.title = "내 정보"
        
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    override func setView() {
        self.view.addSubview(myProfileView)
        self.view.addSubview(signInButtonView)
        self.view.addSubview(surveyButton)
        self.view.addSubview(questionButton)
        self.view.addSubview(signOutButton)
        self.view.addSubview(quitButton)
        
    }
    
    override func setConstraint() {
        myProfileView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
        
        surveyButton.snp.makeConstraints { make in
            make.top.equalTo(myProfileView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        signInButtonView.snp.makeConstraints { make in
            make.top.equalTo(surveyButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(120)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.top.equalTo(signInButtonView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        quitButton.snp.makeConstraints { make in
            make.top.equalTo(signOutButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
        
        questionButton.snp.makeConstraints { make in
            make.top.equalTo(quitButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
        }
    }
    
    override func setBind() {
        
    }

}
