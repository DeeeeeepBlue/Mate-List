//
//  SurveyTableViewCell.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/04.
//

import UIKit
import RxSwift
import SnapKit

import Utility

class SurveyTableViewCell: UITableViewCell {
    
    var viewModel: SurveyCellViewModel
    var disposeBag = DisposeBag()
    
    // MARK: - Properties
    static var cellIdentifier = "surveyTableViewCell"
    
    // Container
    private(set) lazy var container: UIStackView = UIStackView()
    private(set) lazy var questionContainer: UIStackView = UIStackView()
    private(set) lazy var answerContainer: UIStackView = UIStackView()
    
    // Element
    private(set) lazy var questionNumber = self.createLabel(size: 14,
                                                            weight: .semibold,
                                                            textColor: .mainblue)
    private(set) lazy var question = self.createLabel(size: 18,
                                                      family: .bold,
                                                      weight: .bold)
    private(set) lazy var yes = self.createButton(text: "예")
    private(set) lazy var no = self.createButton(text:"아니오")
    private(set) lazy var textInput = self.createButton(text:"아니오")
    
    private(set) lazy var checkbox = self.createUIView(width: 70, height: 20)
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.viewModel = SurveyCellViewModel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.styleUI()
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

//MARK: - Configure UI
extension SurveyTableViewCell {
    func updateUI(question: String, questionNumber: Int) {
        // ViewModel -> ViewController -> Cell -> CellViewModel 식으로 컨텐츠 전달
        viewModel.question
            .onNext(question)
        
        viewModel.questionNumber
            .onNext(questionNumber)
    }
    
    // Bind action and content
    private func bind() {

        // Bind label text
        viewModel.question
            .bind(to: self.question.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.questionNumber
            .map{ "Q\($0+1)" }
            .bind(to: self.questionNumber.rx.text)
            .disposed(by: disposeBag)
        
        //Bind button action
        yes.rx.tap
            .bind {
                self.yes.backgroundColor = .mainblue
            }
            .disposed(by: disposeBag)
        
        no.rx.tap
            .bind {
                self.no.backgroundColor = .mainblue
            }
            .disposed(by: disposeBag)
        
    }
    
    // Set UI style
    private func styleUI(){
        self.questionNumber.tintColor = .blue
    }
    
    
    // Set UI layout
    private func configureUI() {
        self.contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        // AddView
        self.questionContainer.addArrangedSubview(questionNumber)
        self.questionContainer.addArrangedSubview(question)
        
        self.answerContainer.addArrangedSubview(yes)
        self.answerContainer.addArrangedSubview(no)
        
        self.container.addArrangedSubview(questionContainer)
        self.container.addArrangedSubview(answerContainer)
        
        self.contentView.addSubview(container)
        
        // Set StackView
        self.questionContainer.axis = .vertical
        self.questionContainer.alignment = .leading
        self.questionContainer.spacing = 5
        
        self.answerContainer.axis = .horizontal
        self.answerContainer.alignment = .leading
        self.answerContainer.distribution = .fillEqually
        self.answerContainer.spacing = 10
        
        self.container.axis = .vertical
        self.container.alignment = .leading
        self.container.spacing = 20
    
        
        // Constraints
        self.container.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            
            self.answerContainer.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            
            self.questionNumber.snp.makeConstraints { make in
//                make.top.equalToSuperview()
//                make.leading.equalToSuperview()
            }
            
            self.question.snp.makeConstraints { make in
//                make.top.equalToSuperview().offset(0)
//                make.leading.equalToSuperview()
            }
        }
    }
    
    // MARK: - Button Action
    
}
