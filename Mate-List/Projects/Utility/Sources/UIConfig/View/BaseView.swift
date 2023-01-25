//
//  BaseView.swift
//  MateList
//
//  Created by 강민규 on 2022/12/27.
//

import UIKit

open class BaseView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        bind()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func configureUI() {}
    open func bind() {}
}
