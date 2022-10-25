//
//  NickNameViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/10/24.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift

class NickNameViewController: UIViewController {
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    let tfNickName : UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.black.cgColor
        tf.addLeftPadding()
        return tf
    }()
    
    let lb : UILabel = {
       let lb = UILabel()
        lb.text = "닉네임을 설정해주세요."
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        return lb
        
    }()
    
    let checkButton : UIButton = {
        let bt = UIButton()
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 0.5
        bt.setTitleColor(.black, for: .normal)
        bt.setTitle("중복 확인", for: .normal)
        
        return bt
    }()
    
    let checkLb : UILabel = {
        let lb = UILabel()
        lb.textColor = .gray
        lb.text = "중복 확인을 해주세요."
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()
    
    let finButton : UIButton = {
        let bt = UIButton()
        bt.layer.cornerRadius = 8
        bt.setTitle("완료", for: .normal)
        bt.backgroundColor = UIColor.systemBlue
        return bt
    }()
    
    //MARK: - binding
    private func bind(){
        var flag = false
        var str = ""
        
        tfNickName.rx.text.orEmpty
            .subscribe(onNext: { text in
                str = text
            })
            .disposed(by: disposeBag)
        
        
        checkButton.rx.tap
            .bind{
                FireStoreService.db.collection("User").whereField("NickName", isEqualTo: str).addSnapshotListener { (querySnapshot, err) in
                    guard let documents = querySnapshot?.documents else {
                        print("Error!!!!! : \(err!)")
                        return
                    }
                    let vari = documents.map{$0["NickName"]!}
                    print(type(of: vari), vari)
                    if vari.isEmpty{
                        DispatchQueue.main.async {
                            self.checkLb.text = "사용 가능한 닉네임입니다."
                            self.checkLb.textColor = .green
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            self.checkLb.text = "사용 불가능한 닉네임입니다."
                            self.checkLb.textColor = .red
                        }
                    }
                }
            }
        
        finButton.rx.tap
            .bind{
                //TODO: Firebase에 닉네임 설정
                
                self.dismiss(animated: true)
        }
        
    }
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setView()
        setConstraint()
        bind()
        
        
    }
    

    //MARK: - Setting
    func setView() {
        self.view.addSubview(tfNickName)
        self.view.addSubview(lb)
        self.view.addSubview(checkLb)
        self.view.addSubview(checkButton)
        self.view.addSubview(finButton)
    }
    
    func setConstraint() {
        lb.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
        }
        
        tfNickName.snp.makeConstraints { make in
            make.top.equalTo(lb.snp.bottom).offset(30)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        checkLb.snp.makeConstraints { make in
            make.top.equalTo(tfNickName.snp.bottom).offset(30)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(30)
            
        }
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(checkLb.snp.bottom).offset(30)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(40)

        }
        finButton.snp.makeConstraints { make in
           
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-100)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
