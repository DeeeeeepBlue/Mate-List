//
//  ReportButton.swift
//  MateList
//
//  Created by 강민규 on 2023/01/06.
//

import UIKit

import SnapKit
import RxSwift

class ReportButton: BaseView {
    private(set) lazy var button: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "light.beacon.max")
        button.setImage(image, for: .normal)
        button.tintColor = .red
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
