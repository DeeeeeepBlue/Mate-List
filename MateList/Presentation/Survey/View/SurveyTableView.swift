//
//  SurveyTableView.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/04.
//

import UIKit
import RxSwift
import RxCocoa

final class SurveyTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }

    func configureUI(){
        self.register(SurveyTableViewCell.self, forCellReuseIdentifier: SurveyTableViewCell.cellIdentifier)
    }
}
