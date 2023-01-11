//
//  DetailViewModel.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import Foundation

class DetailViewModel {
    
    private let detailUseCase: DefaultDetailUseCase
    
    init(detailUseCase: DefaultDetailUseCase) {
        self.detailUseCase = detailUseCase
    }
}
