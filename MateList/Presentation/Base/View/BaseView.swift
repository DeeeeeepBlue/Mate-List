//
//  BaseView.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {}
    
    func bind() {}
}
