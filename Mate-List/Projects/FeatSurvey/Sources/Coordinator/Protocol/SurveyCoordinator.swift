//
//  SurveyCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/09.
//

import Utility

public protocol SurveyCoordinator: Coordinator {
    var surveyViewController: SurveyViewController { get set }
}
