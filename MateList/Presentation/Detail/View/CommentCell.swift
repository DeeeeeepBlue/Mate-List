//
//  CommentCell.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import UIKit

import SnapKit

class CommentCell: UITableViewCell {
    //MARK: - Properties
    var viewModel: CommentCellViewModel
    static var cellIdentifier = "thisIsDetail"
    
    private(set) lazy var topContainer = UIView()
    private(set) lazy var userLabel = self.createLabel(size: 14)
    private(set) lazy var contentsLabel = self.createLabel(size: 16)
    private(set) lazy var dateLabel = self.createLabel(size: 12)
    private(set) lazy var deleteButton = DeleteButton()
    private(set) lazy var reportButton = ReportButton()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.viewModel = CommentCellViewModel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
        self.bind()

    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = CommentCellViewModel()
        super.init(coder: aDecoder)
        self.configureUI()
    }
}

//MARK: - Configure UI
extension CommentCell {
    func configureUI() {
        self.addSubview(topContainer)
        topContainer.addSubview(userLabel)
        topContainer.addSubview(deleteButton)
        topContainer.addSubview(reportButton)
        
        self.addSubview(contentsLabel)
        self.addSubview(dateLabel)
        
        
        userLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        
        reportButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalTo(reportButton.snp.leading)
        }
        
        topContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentsLabel.snp.bottom).inset(12)
            make.trailing.leading.equalToSuperview().inset(12)
        }
      
    }
}

//MARK: - Bind
extension CommentCell {
    func bind() {
        
    }
}
