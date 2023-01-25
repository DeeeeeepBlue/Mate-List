//
//  QuestionButton.swift
//  MateList
//
//  Created by 강민규 on 2022/12/30.
//

import UIKit

import SnapKit

import Utility

final class QuestionButton: BaseView {
    private(set) lazy var label = self.createLabel(size: 18, family: .bold)
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        label.textAlignment = .center
        label.text = "문의하기"
        
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(12)
        }
    }
}
