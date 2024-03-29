//
//  TextField.swift
//  MateList
//
//  Created by 강민규 on 2022/10/24.
//

import Foundation
import UIKit

extension UITextField {
  public func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
