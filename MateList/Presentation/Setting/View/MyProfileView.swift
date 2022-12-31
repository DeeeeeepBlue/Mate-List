//
//  MyProfileView.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

final class MyProfileView: BaseView {
    
    private(set) lazy var nameTitleLabel = self.createLabel(size: 14, family: .bold)
    private(set) lazy var nameLabel = self.createLabel(size: 14, family: .bold)
    private(set) lazy var emailTitleLabel = self.createLabel(size: 14, family: .bold)
    private(set) lazy var emailLabel = self.createLabel(size: 14, family: .bold)
    
    override func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        
        nameLabel.backgroundColor = .blue
        emailLabel.backgroundColor = .green
        
        nameTitleLabel.text = "이름"
        emailTitleLabel.text = "이메일"
        
        self.addSubview(nameTitleLabel)
        self.addSubview(nameLabel)
        self.addSubview(emailTitleLabel)
        self.addSubview(emailLabel)
        
        nameTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(nameTitleLabel.snp.trailing).offset(12)
            make.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-12)
            
        }
        
        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.leading.equalTo(emailTitleLabel.snp.trailing).offset(12)
            make.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    override func bind() {
        print()
    }
}
