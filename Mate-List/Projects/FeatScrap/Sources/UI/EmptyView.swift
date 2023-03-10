//
//  EmptyView.swift
//  FeatScrap
//
//  Created by 강민규 on 2023/03/07.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import UIKit

import SnapKit

import Utility

class EmptyView: BaseView {
    
     var emptyView : UIView = {
        let v = UIView()
        let lb = UILabel()
         
         v.addSubview(lb)
         
        lb.text = "Empty!"
        lb.textColor = .gray
        lb.snp.makeConstraints {$0.center.equalToSuperview()}
    
        v.isHidden = false
        
        return v
    }()
  
    override func configureUI() {
        self.addSubview(emptyView)
        
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
}
