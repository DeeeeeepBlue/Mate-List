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


class HomeViewController: UIViewController {

    private let homeTableView = HomeTableView()
    private let writeButton = WriteButton()
    let viewModel: HomeViewModelType
    
    
    private let disposeBag = DisposeBag()
    
    init(homeViewModel: HomeViewModelType){
        self.viewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = HomeViewModel(homeUseCase: HomeDefaultUseCase(firestoreRepository: DefaultFirestoreRepository()))
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setView()
        setConstraint()
        setBind()
    }
    
    func style() {
        self.view.backgroundColor = .white
        navigationController?.title = "Mate List"
    
        // 네비게이션 뒤에 안보이게
        let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
    }
    
    func setBind() {
        let firstLoad = rx.viewWillAppear
            .map { _ in () }
        
        let reload = homeTableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .map{ _ in } ?? Observable.just(())
        
        Observable.merge([firstLoad, reload])
            .bind(to: viewModel.appear)
            .disposed(by: disposeBag)
        
        viewModel.allPosts
            .bind(to: homeTableView.rx.items(cellIdentifier: HomeCell.cellIdentifier, cellType: HomeCell.self)){
                _, post, cell in
                cell.updateUI(post: post)
            }
            .disposed(by: disposeBag)
    }
    
    func setView() {
        self.view.addSubview(homeTableView)
        self.view.addSubview(writeButton)
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
