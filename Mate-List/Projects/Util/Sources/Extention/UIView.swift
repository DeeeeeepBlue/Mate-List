//
//  UIView.swift
//  MateList
//
//  Created by 강민규 on 2022/12/30.
//

import UIKit

extension UIView {
    func createLabel(size: CGFloat, family: UIFont.Family = .regular) -> UILabel {
        let label = UILabel()
        label.font = .notoSans(size: size, family: family)
        return label
    }
    
    func createUIView(width: CGFloat, height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        return view
    }
    
    func createSpacer() -> UIView {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }
}

