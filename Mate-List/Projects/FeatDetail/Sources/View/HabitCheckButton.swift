//
//  HabitCheckButton.swift
//  MateList
//
//  Created by 강민규 on 2023/01/10.
//

import UIKit

import SnapKit

import Utility


class HabitCheckButton: BaseView {
    
    private(set) var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("생활 패턴 보기", for: .normal)
        return button
    }()
    
    override func configureUI() {
        self.addSubview(button)
        
        self.button.layer.cornerRadius = 17.5
        self.button.layer.borderWidth = 1
        
        button.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(5)
        }
    }
}
