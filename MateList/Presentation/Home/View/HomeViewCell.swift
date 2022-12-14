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
    
    private(set) lazy var titleLabel = self.createLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    func updateUI(post: Post) {
        self.titleLabel.text = post.title
    }
}

private extension HomeViewCell {
    func configureUI() {
        self.contentView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func createLabel() -> UILabel {
        let label = UILabel()
        
        return label
    }
}
