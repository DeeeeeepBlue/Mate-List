//
//  UIView.swift
//  MateList
//
//  Created by 강민규 on 2022/12/30.
//

import UIKit

extension UIView {
    func createLabel(size: CGFloat,
                     family: UIFont.Family = .regular,
                     weight: UIFont.Weight = .regular,
                     textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        // 폰트 적용 안되는 중
//        label.font = .notoSans(size: size, family: UIFont.Family.black)
        label.textColor = textColor
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
    
    func createButton(text: String) -> UIButton{
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitleColor(.systemGray, for: .normal)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = UIColor.systemGray5
        button.layer.cornerRadius = 10.0
        
        return button
    }
    
    func createSpacer() -> UIView {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }
}

