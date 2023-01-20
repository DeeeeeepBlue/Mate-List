//
//  DetailTextView.swift
//  checkMate
//
//  Created by 한상윤 on 2022/02/22.
//

import UIKit

class DetailTextView: UITextView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        setTextView()
    }

    func setTextView() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
    }
}
