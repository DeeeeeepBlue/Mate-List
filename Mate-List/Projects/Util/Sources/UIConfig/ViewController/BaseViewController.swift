//
//  BaseViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setView()
        setConstraint()
        setBind()
    }
    
    func style() {
        view.backgroundColor = .white
    }
    func setView() {}
    func setConstraint() {}
    func setBind() {}

}