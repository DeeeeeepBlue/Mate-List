//
//  DefaultSurveyCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/09.
//

import Foundation
import UIKit
import Inject

import Utility

public class DefaultSurveyCoordinator: SurveyCoordinator {
    
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var surveyViewController: SurveyViewController
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType = .survey
    
    required public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.surveyViewController = SurveyViewController()

    }
    
    public func start() {
        // ⚠️ Inject 사용중
        self.navigationController.pushViewController(Inject.ViewControllerHost(SurveyViewController()), animated: true)
    }
}

extension DefaultSurveyCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: Coordinator) {
        // 자식 뷰를 삭제하는 델리게이트 (자식 -> 부모 접근 -> 부모에서 자식 삭제)
        self.childCoordinators = self.childCoordinators
            .filter({ $0.type != childCoordinator.type })
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
