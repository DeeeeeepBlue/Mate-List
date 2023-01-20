//
//  TopTitleView.swift
//  MateList
//
//  Created by 강민규 on 2023/01/06.
//

import UIKit

import SnapKit

class TopTitleView: BaseView {
    private(set) lazy var userLabel = self.createLabel(size: 14)
    private(set) lazy var titleLabel = self.createLabel(size: 18,family: .bold)
    private(set) lazy var reportButton = ReportButton()
    private(set) lazy var deleteButton = DeleteButton()
    
    override func configureUI() {
        self.addSubview(userLabel)
        self.addSubview(titleLabel)
        self.addSubview(reportButton)
        self.addSubview(deleteButton)
        
        userLabel.text = "고먐미의 글"
        titleLabel.text = "제목"
        
        userLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.top.equalTo(userLabel.snp.bottom).offset(12)
        }
        
        reportButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(12)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(reportButton.snp.bottom).offset(12)
        }
    }
}
