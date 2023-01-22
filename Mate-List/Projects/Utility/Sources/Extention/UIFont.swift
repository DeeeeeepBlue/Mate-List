//
//  UIFont.swift
//  MateList
//
//  Created by 강민규 on 2022/12/15.
//

import UIKit

extension UIFont {
    enum Family: String {
        case black, bold, light, medium, regular, thin
    }
    
    static func notoSans(size: CGFloat = 10, family: Family = .regular) -> UIFont {
        return UIFont(name: "NotoSansKR-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func notoSansBoldItalic(size: CGFloat = 10) -> UIFont {
        return UIFont(name: "NotoSans-boldItalic", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}


