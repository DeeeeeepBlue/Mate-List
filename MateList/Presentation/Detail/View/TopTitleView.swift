//
//  TopTitleView.swift
//  MateList
//
//  Created by 강민규 on 2023/01/06.
//

import UIKit

import SnapKit

class TopTitleView: BaseView {
    
    private let reportButton = ReportButton()
    
    override func configureUI() {
        self.addSubview(reportButton)
        
        reportButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(12)
        }
    }
}
