//
//  CommentTableView.swift
//  MateList
//
//  Created by 강민규 on 2023/01/06.
//

import UIKit

import RxSwift
import RxCocoa

final class CommentTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }

    func configureUI(){
        self.register(HomeCell.self, forCellReuseIdentifier: CommentCell.cellIdentifier)
    }
}
