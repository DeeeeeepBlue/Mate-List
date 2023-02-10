//
//  HomeCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/19.
//

import Foundation

import Utility
import Service

public protocol HomeCoordinator: Coordinator {
    var homeViewController: HomeViewController { get set }

    func startSurveyFlow()
    func showDetailFlow(postData: Post?)
}
