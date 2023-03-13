//
//  ScrapViewController.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/25.
//

import UIKit
import Firebase
import RxCocoa
import RxSwift
import RxViewController

import Service
import Utility


class ScrapViewController: UIViewController {
    //MARK: - Properties
    // Init
    var scrapTableView = ScrapTableView()
    var emptyView = EmptyView()
    var disposeBag = DisposeBag()
    
    // Optional
    var viewModel: ScrapViewModel?

    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setView()
        setConstraint()
        setBind()

    }
    
    // MARK: - function
    
    func style() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = "스크랩"
    }
    
    func setView() {
        self.view.addSubview(scrapTableView)
        self.view.addSubview(emptyView)
    }
    
    func setConstraint() {
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setBind() {
        /// 설명 : 뷰 로드시 이벤트 전달
        let firstLoad = rx.viewWillAppear
            .map { _ in () }
            .asObservable()
        
        /// 설명 : input, output 초기화
        let input = ScrapViewModel.Input(
            appear: firstLoad,
            cellTapEvent: scrapTableView.rx.itemSelected.asObservable()
        )
        
        let output = self.viewModel?.transform(from: input, disposeBag: disposeBag)
        
        /// 설명 : 테이블 뷰 Binding
        output?.allPosts
            .bind(to: scrapTableView.rx.items(cellIdentifier: ScrapCell.cellIdentifier, cellType: ScrapCell.self)) {
                _, post, cell in
                cell.updateUI(post: post)
                cell.disposeBag = DisposeBag()
            }
            .disposed(by: disposeBag)
        
         
        /// 설명 : postRelay에 넘겨준 event에 값이 비어있으면 EmptyView를 보이게 한다.
        output?.allPosts.asObservable()
            .subscribe { event in
                let result = event.element ?? []
                if result.isEmpty {
                    self.emptyView.isHidden = false
                } else {
                    self.emptyView.isHidden = true
                }
            }
            .disposed(by: disposeBag)

    }
}
