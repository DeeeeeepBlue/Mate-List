//
//  DeleteButton.swift
//  MateList
//
//  Created by 강민규 on 2023/01/06.
//

import UIKit

import SnapKit

class DeleteButton: BaseView {
    private(set) lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override func configureUI() {
        self.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
    }
}
