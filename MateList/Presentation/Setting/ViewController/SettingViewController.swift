//
//  SettingViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

class SettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func style() {
        super.style()
        
        navigationController?.title = "Mate List"
        
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
    }
    
    override func setView() {
        
    }
    
    override func setConstraint() {
        
    }
    
    override func setBind() {
        
    }

}
