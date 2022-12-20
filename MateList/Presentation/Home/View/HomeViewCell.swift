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
    // MARK: - Properties
    static var cellIdentifier = "thisIsHome"
    
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
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
}
//MARK: - Override
extension HomeViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}

//MARK: - ConfigureUI
extension HomeViewCell {
    func updateUI(post: Post) {
        self.matchLabel.text = "나와의 적합도"
        self.matchPercentLabel.text = "100%"
        self.titleLabel.text = post.title
        self.contentLabel.text = post.contents
        self.dateLabel.text = post.date
        self.userLabel.text = post.uid
    }
    
    private func configureUI() {
        self.contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        // AddView
        self.topConatiner.addArrangedSubview(matchLabel)
        self.topConatiner.addArrangedSubview(matchPercentView)
        self.topConatiner.addArrangedSubview(createSpacer())
        self.matchPercentView.addSubview(matchPercentLabel)
        self.contentView.addSubview(topConatiner)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(bottomContainer)
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

//MARK: - Create func
private extension HomeViewCell {
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
        return view
    }
    
    func createSpacer() -> UIView {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }
}
