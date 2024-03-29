//
//  HomeViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/12/13.
//

import UIKit

import RxSwift
import RxCocoa
import RxViewController
import SnapKit

public class HomeViewController: UIViewController {

    private let homeTableView = HomeTableView()
    private let writeButton = WriteButton()
    
    // TODO: Coordinator에서 인스턴스화하는 방법으로 고치기 // 옵셔널 고치기
    var viewModel: HomeViewModel?
    
    
    private var disposeBag = DisposeBag()

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setView()
        setConstraint()
        setBind()
    }

    
    func style() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = "홈"
    }
    
    func setBind() {
        let firstLoad = rx.viewWillAppear
            .map { _ in () }
            .asObservable()
        
        
        let input = HomeViewModel.Input(
            appear: firstLoad,
            cellTapEvent: homeTableView.rx.itemSelected.asObservable()
        )
        
        let output = self.viewModel?.transform(from: input, disposeBag: disposeBag)
        
        output?.allPosts
            .bind(to: homeTableView.rx.items(cellIdentifier: HomeCell.cellIdentifier, cellType: HomeCell.self)){
                _, post, cell in
                cell.updateUI(post: post)
                cell.disposeBag = DisposeBag()
            }
            .disposed(by: disposeBag)
        
        
    }
    
    func setView() {
        self.view.addSubview(homeTableView)
        self.view.addSubview(writeButton)
        
        // ⚠️ 임시로 Survey로 가는 버튼 생성
        let surveyButton = UIButton()
        self.view.addSubview(surveyButton)
        surveyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(50)
        }
        surveyButton.setTitle("생활패턴조사", for: .normal)
        surveyButton.setTitleColor(.black, for: .normal)
        surveyButton.backgroundColor = .orange
        surveyButton.addTarget(self, action: #selector(goSurveyPage(_:)), for: .touchUpInside)
        
    }
    
    @objc func goSurveyPage (_ sender:UIButton) {
        var newHomeCoordinator = DefaultHomeCoordinator(self.navigationController!)
        newHomeCoordinator.startSurveyFlow()
    }
    
    func setConstraint() {
        homeTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        writeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(10)
        }
    }
}
