//
//  SurveyTableViewCell.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/04.
//

import UIKit
import RxSwift
import SnapKit

class SurveyTableViewCell: UITableViewCell {
    
    var viewModel: SurveyCellViewModel
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    static var cellIdentifier = "surveyTableViewCell"
    
    private(set) lazy var conatiner: UIStackView = UIStackView()
    
    private(set) lazy var question = self.createLabel(size: 14, family: .bold)
    private(set) lazy var checkbox = self.createUIView(width: 70, height: 20)
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.viewModel = SurveyCellViewModel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
        self.bind()

    }

    required init?(coder aDecoder: NSCoder) {
        self.viewModel = SurveyCellViewModel()
        super.init(coder: aDecoder)
        self.configureUI()
    }
}
//MARK: - Override
extension SurveyTableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}

//MARK: - ConfigureUI
extension SurveyTableViewCell {
    func updateUI(question: String) {
//        // ViewModel에 post 넘기기
        viewModel.question
            .onNext(question)
    }
    
    private func bind() {

        viewModel.question
            .bind(to: self.question.rx.text)
            .disposed(by: disposeBag)
//
//        viewModel.title
//            .bind(to: self.titleLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.contents
//            .bind(to: self.contentLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.date
//            .bind(to: self.dateLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.user
//            .bind(to: self.userLabel.rx.text)
//            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        self.contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        // AddView
        self.conatiner.addArrangedSubview(question)
        self.conatiner.addArrangedSubview(checkbox)
        self.contentView.addSubview(conatiner)
        
        // Constraints
        self.conatiner.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
            
            self.question.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
            }
            self.checkbox.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.trailing.equalToSuperview().offset(-10)
            }
        }
    }
}
