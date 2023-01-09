//
//  MiddleView.swift
//  MateList
//
//  Created by 강민규 on 2023/01/06.
//

import UIKit

import SnapKit

class MiddleView: BaseView {
    
    private(set) lazy var contentTextField: UITextField = {
        let textField = UITextField()
        
        textField.text = "하하"
        
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    private(set) lazy var dateLabel = self.createLabel(size: 14)
    
    private(set) lazy var habitCheckButton: HabitCheckButton = HabitCheckButton()
    
    override func configureUI() {
        self.addSubview(contentTextField)
        self.addSubview(dateLabel)
        self.addSubview(habitCheckButton)
        
        
        
        dateLabel.text = "2022/03/06"
        
        contentTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentTextField.snp.bottom).offset(12)
            make.trailing.leading.equalToSuperview().inset(12)
            make.height.equalTo(20)
        }
        
        habitCheckButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.trailing.leading.bottom.equalToSuperview().inset(12)
        }
    }
}
