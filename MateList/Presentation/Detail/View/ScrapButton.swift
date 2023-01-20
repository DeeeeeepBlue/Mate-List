//
//  ScrapButton.swift
//  MateList
//
//  Created by 강민규 on 2023/01/15.
//

import UIKit

import SnapKit

class ScrapButton: BaseView {
    var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override func configureUI() {
        self.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
    }
    
    func barButton() -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(customView: self)
        
        return barButtonItem
    }
}
