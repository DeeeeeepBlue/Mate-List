//
//  HomeViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/12/13.
//

import UIKit

import SnapKit

class HomeViewController: UIViewController {

    private let homeTableView = HomeTableView()
    private let writeButton = WriteButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setView()
        setConstraint()
    }
    
    override func loadView(){
        self.view = homeTableView
    }
    
    func style() {
        navigationController?.title = "Mate List"
    }
    
    func setView() {
        self.view.addSubview(homeTableView)
        self.view.addSubview(writeButton)
    }
    
    func setConstraint() {
        homeTableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        writeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(10)
        }
    }
}
