//
//  HomeViewCell.swift
//  MateList
//
//  Created by 강민규 on 2022/12/13.
//

import UIKit

import RxSwift
import SnapKit

class HomeViewCell: UITableViewCell {
    static var cellIdentifier = "thisIsHome"
    
    private(set) lazy var bottomContainer: UIStackView = {
        let view = UIStackView()

        return view
    }()
    
    private(set) lazy var spacer: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private(set) lazy var matchLabel = self.createLabel(size: 14, family: .bold)
    private(set) lazy var titleLabel = self.createLabel(size: 14)
    private(set) lazy var contentLabel = self.createLabel(size: 14)
    private(set) lazy var dateLabel = self.createLabel(size: 14)
    private(set) lazy var userLabel = self.createLabel(size: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    func updateUI(post: Post) {
        self.matchLabel.text = "나와의 적합도"
        self.titleLabel.text = post.title
        self.contentLabel.text = post.contents
        self.dateLabel.text = post.date
        self.userLabel.text = post.author
    }
}

private extension HomeViewCell {
    func configureUI() {
        self.contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        // AddView
        self.contentView.addSubview(matchLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(bottomContainer)
        self.bottomContainer.addArrangedSubview(dateLabel)
        self.bottomContainer.addArrangedSubview(spacer)
        self.bottomContainer.addArrangedSubview(userLabel)
        
        // Constraints
        self.matchLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchLabel.snp.bottom).offset(4)
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
        }
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        self.userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func createLabel(size: CGFloat, family: UIFont.Family = .regular) -> UILabel {
        let label = UILabel()
        label.font = .notoSans(size: size, family: family)
        return label
    }
    
    func createUIView(width: CGFloat, height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        view.layer.borderWidth = 0.5
        return view
    }
}
