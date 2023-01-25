//
//  SurveyButton.swift
//  MateList
//
//  Created by 강민규 on 2022/12/30.
//

import UIKit

import SnapKit

import Utility

public final class SurveyButton: BaseView {
    
    private(set) lazy var label = self.createLabel(size: 18, family: .bold)
    
    public override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        label.textColor = .blue
        label.textAlignment = .center
        label.text = "생활 패턴 입력"
        
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(12)
        }
        
    }
}

