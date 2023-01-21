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
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }

    func configureUI(){
        self.register(CommentCell.self, forCellReuseIdentifier: CommentCell.cellIdentifier)
    }
}

extension CommentTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
