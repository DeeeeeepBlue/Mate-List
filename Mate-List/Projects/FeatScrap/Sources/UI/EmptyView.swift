//
//  EmptyView.swift
//  FeatScrap
//
//  Created by 강민규 on 2023/03/07.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import UIKit

import SnapKit

class EmptyView: UIView {
    
    lazy var emptyView : UIView = {
        let v = UIView()
        let lb = UILabel()
        lb.text = "Empty!"
        lb.textColor = .gray
        v.addSubview(lb)
        lb.snp.makeConstraints {$0.center.equalToSuperview()}
        v.isHidden = true
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
        constraintsView()
    }
    
    func setView() {
        self.addSubview(emptyView)
    }

    func constraintsView() {
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
}
