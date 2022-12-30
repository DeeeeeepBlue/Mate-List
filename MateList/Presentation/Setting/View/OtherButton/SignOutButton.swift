//
//  SignOutButton.swift
//  MateList
//
//  Created by 강민규 on 2022/12/30.
//

import UIKit

final class SignOutButton: BaseView {
    
    private(set) lazy var label = self.createLabel(size: 14, family: .bold)
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        
        label.backgroundColor = .yellow
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(12)
        }
    }
    
    override func bind() {
        print()
    }
}
