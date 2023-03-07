//
//  ScrapCell.swift
//  FeatScrap
//
//  Created by 강민규 on 2023/03/07.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import UIKit

import RxSwift
import SnapKit

import Utility
import Service

class ScrapCell: UITableViewCell {
    
    var viewModel: ScrapCellViewModel
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    static var cellIdentifier = "thisIsHome"
    
    private(set) lazy var baseView: UIView = UIView()
    
    private(set) lazy var topConatiner: UIStackView = UIStackView()
    private(set) lazy var bottomContainer: UIStackView = UIStackView()
    
    private(set) lazy var matchLabel = self.createLabel(size: 14, family: .bold)
    private(set) lazy var matchPercentView = self.createUIView(width: 70, height: 20)
    private(set) lazy var matchPercentLabel = self.createLabel(size: 14, family: .medium)
    private(set) lazy var titleLabel = self.createLabel(size: 14)
    private(set) lazy var contentLabel = self.createLabel(size: 14)
    private(set) lazy var dateLabel = self.createLabel(size: 14)
    private(set) lazy var userLabel = self.createLabel(size: 14)
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.viewModel = ScrapCellViewModel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
        self.bind()

    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = ScrapCellViewModel()
        super.init(coder: aDecoder)
        self.configureUI()
        self.bind()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
        
    }
}
//MARK: - Override
extension ScrapCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}

//MARK: - ConfigureUI
extension ScrapCell {
    func updateUI(post: Post) {
        // 적합도
        self.matchLabel.text = "적합도"
        
        // ViewModel에 post 넘기기
        viewModel.post
            .onNext(post)
    }
    
    private func bind() {

        viewModel.matchPercent
            .bind(to: self.matchPercentLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.contents
            .bind(to: self.contentLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.date
            .bind(to: self.dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.user
            .bind(to: self.userLabel.rx.text)
            .disposed(by: disposeBag)

    }
    
    private func configureUI() {
        self.addSubview(baseView)
        
        baseView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        // AddView
        self.topConatiner.addArrangedSubview(matchLabel)
        self.topConatiner.addArrangedSubview(matchPercentView)
        self.topConatiner.addArrangedSubview(createSpacer())
        self.matchPercentView.addSubview(matchPercentLabel)
        self.baseView.addSubview(topConatiner)
        self.baseView.addSubview(titleLabel)
        self.baseView.addSubview(contentLabel)
        self.baseView.addSubview(bottomContainer)
        self.bottomContainer.addArrangedSubview(dateLabel)
        self.bottomContainer.addArrangedSubview(createSpacer())
        self.bottomContainer.addArrangedSubview(userLabel)
        
        // Constraints
        self.topConatiner.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
            
            self.matchLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
            }
            self.matchPercentView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalTo(matchLabel.snp.trailing)
            }
        }
        
        self.matchPercentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
        }
       
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topConatiner.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        self.bottomContainer.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            
            self.dateLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
            }
            self.userLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
        
    }
}

