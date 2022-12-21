//
//  HomeTableVIewCellViewModel.swift
//  MateList
//
//  Created by 강민규 on 2022/12/20.
//


import RxSwift

protocol HomeTableViewCell {
    var match: Observable<String> { get }
    var matchPercent: Observable<String> { get }
    var title: Observable<String> { get }
    var content: Observable<String> { get }
    var date: Observable<String> { get }
    var user: Observable<String> { get }
}

class HomeTableViewCellViewModel: HomeTableViewCell {
    var match: Observable<String>
    var matchPercent: Observable<String>
    var title: Observable<String>
    var content: Observable<String>
    var date: Observable<String>
    var user: Observable<String>
    
    init() {
       
        
        
    }
    
    
    
    
}
