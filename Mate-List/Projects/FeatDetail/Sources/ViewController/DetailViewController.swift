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
import FirebaseAuth

import Utility

public class DetailViewController: BaseViewController {
    //MARK: - Properties
    var viewModel: DetailViewModel?
    var disposeBag = DisposeBag()
    
    private let topTitleView = TopTitleView()
    private let middleView = MiddleView()
    private let bottomInputView = BottomInputView()
    private let commentTableView = CommentTableView()
    private let scrapButton = ScrapButton()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - Setting
    
    public override func style() {
        super.style()
    }
    
    public override func setView() {
        self.view.addSubview(topTitleView)
        self.view.addSubview(middleView)
        self.view.addSubview(bottomInputView)
        self.view.addSubview(commentTableView)
        self.navigationItem.rightBarButtonItem = scrapButton.barButton()
    }
    
    public override func setConstraint() {
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
    
    public override func setBind() {
        let firstLoad = rx.viewWillAppear
            .map { _ in () }
            .asObservable()
        
        // 탭 하면 이벤트 전달
        let tapScrapButton = scrapButton.button.rx.tap
            .map{ _ in () }
            .debug()
            .asObservable()
            
        // 인풋 생성
        let input = DetailViewModel.Input(
            appear: firstLoad,
            tapScrap: tapScrapButton
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
        
        output?.allComments
            .bind(to: commentTableView.rx.items(cellIdentifier: CommentCell.cellIdentifier, cellType: CommentCell.self)){
                _, comment, cell in
                
                cell.updateUI(comment: comment)
                
                cell.reportButton.button.rx.tap
                    .bind { _ in
                        self.reportUserAlert(uid: comment.uid)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.deleteButton.button.rx.tap
                    .bind { _ in
                        self.viewModel?.deleteComment(pid: comment.pid, cid: comment.cid)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)

        output?.scrapFill
            .debug()
            .bind(onNext: { isScrap in
                if isScrap {
                    self.scrapButton.button.setImage(UIImage(systemName: "star.fill"), for: .normal)
                } else {
                    self.scrapButton.button.setImage(UIImage(systemName: "star"), for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
        topTitleView.reportButton.button.rx
            .tap
            .bind {
                self.reportPostAlert()
            }.disposed(by: disposeBag)
        
        topTitleView.deleteButton.button.rx
            .tap
            .bind {
                self.viewModel?.deletePost()
            }.disposed(by: disposeBag)
        
    }
    
    // 유저가 로그인 했는지 확인
    func haveUesr() -> Bool {
        guard Auth.auth().currentUser == nil else { return true }
        let alert = UIAlertController(title: "유저가 없습니다", message: "로그인을 해주세요!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        return false
    }
    
    func reportPostAlert() {
        if self.haveUesr() {
            let alert = UIAlertController(title: "차단", message: "작성자를 차단하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "차단", style: .destructive) { _ in
                self.viewModel?.reportPostUser()
                self.dismiss(animated: true)
                
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    func reportUserAlert(uid: String) {
        if self.haveUesr() {
            let alert = UIAlertController(title: "차단", message: "작성자를 차단하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "차단", style: .destructive) { _ in
                self.viewModel?.reportUser(uid: uid)
                self.dismiss(animated: true)
                
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
