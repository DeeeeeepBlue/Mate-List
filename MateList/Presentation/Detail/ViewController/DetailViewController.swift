//
//  DetailViewController.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import UIKit

import SnapKit

class DetailViewController: BaseViewController {
    //MARK: - Properties
    private let topTitleView = TopTitleView()
    private let middleView = MiddleView()
    private let bottomInputView = BottomInputView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - Setting
    
    override func style() {
        super.style()
    }
    
    override func setView() {
        self.view.addSubview(topTitleView)
        self.view.addSubview(middleView)
        self.view.addSubview(bottomInputView)
    }
    
    override func setConstraint() {
        topTitleView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topTitleView)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        bottomInputView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func setBind() {
        
    }

}
