//
//  BaseViewController.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

open class BaseViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setView()
        setConstraint()
        setBind()
    }
    
    open func style() {
        view.backgroundColor = .white
    }
    open func setView() {}
    open func setConstraint() {}
    open func setBind() {}

}
