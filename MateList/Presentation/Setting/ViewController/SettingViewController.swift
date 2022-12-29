//
//  SettingViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

class SettingViewController: BaseViewController {
    //MARK: - Properties
    private let myProfileView = MyProfileView()
    private let signInButtonView = SignInButtonView()
    private let nickNameView = NickNameView()
    private let agreeView = AgreeView()
    
    
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
        self.view.addSubview(nickNameView)
        self.view.addSubview(agreeView)
    }
    
    override func setConstraint() {
        
    }
    
    override func setBind() {
        
    }

}
