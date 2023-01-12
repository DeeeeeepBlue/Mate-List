//
//  DetailViewController.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import UIKit

import SnapKit
import RxViewController
import RxSwift

class DetailViewController: BaseViewController {
    //MARK: - Properties
    var viewModel: DetailViewModel?
    var disposeBag = DisposeBag()
    
    private let topTitleView = TopTitleView()
    private let middleView = MiddleView()
    private let bottomInputView = BottomInputView()
    private let commentTableView = CommentTableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - Setting
    
    override func style() {
        super.style()
    }
    
    override func setView() {
        self.view.addSubview(topTitleView)
        self.view.addSubview(middleView)
        self.view.addSubview(bottomInputView)
        self.view.addSubview(commentTableView)
    }
    
    override func setConstraint() {
        topTitleView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topTitleView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(bottomInputView.snp.top).offset(-12)
        }
        
        bottomInputView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func setBind() {
        let firstLoad = rx.viewWillAppear
            .map { _ in () }
            .asObservable()
        
        let input = DetailViewModel.Input(
            appear: firstLoad
        )
        
        let output = self.viewModel?.transform(from: input)
        
        self.bindView(output: output)
    }
    
    func bindView(output: DetailViewModel.Output?) {
        output?.userText
            .bind(to: topTitleView.userLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?.contentsText
            .bind(to: middleView.contentTextField.rx.text)
            .disposed(by: disposeBag)
        
        output?.dateText
            .bind(to: middleView.dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?.titleText
            .bind(to: topTitleView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}
