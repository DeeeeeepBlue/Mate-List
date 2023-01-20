//
//  SurveyViewController.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/04.
//

import Foundation

import UIKit

import RxSwift
import RxCocoa
import RxViewController
import SnapKit


class SurveyViewController: UIViewController {

    // UI
    private let surveyTableView = SurveyTableView()

    // ViewModel: Coordinator에서 인스턴스화하는 방법으로 고치기
    var viewModel: SurveyViewModel = SurveyViewModel()
    
    // Rx
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setView()
        setConstraint()
        setBind()
    }
    
    func setStyle() {
        self.view.backgroundColor = .systemBackground
//        navigationController?.title = "Mate List"
    
        // 네비게이션 뒤에 안보이게
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
    }
    
    func setBind() {
//        let firstLoad = rx.viewWillAppear
//            .map { _ in () }
//
//        let reload = surveyTableView.refreshControl?.rx
//            .controlEvent(.valueChanged)
//            .map{ _ in } ?? Observable.just(())
//
//        Observable.merge([firstLoad, reload])
//            .bind(to: viewModel.appear )
//            .disposed(by: disposeBag)

        viewModel.questions
            .bind(to: surveyTableView.rx.items(cellIdentifier: SurveyTableViewCell.cellIdentifier, cellType: SurveyTableViewCell.self)){
                index, question, cell in
                cell.updateUI(question: question.toKrQuestion(), questionNumber: index)
            }
            .disposed(by: disposeBag)
    }
    
    func setView() {
        self.view.addSubview(surveyTableView)
    }
    
    func setConstraint() {
        surveyTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
