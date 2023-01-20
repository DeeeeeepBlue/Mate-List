//
//  DefaultSurveyCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2023/01/09.
//

import Foundation
import UIKit
import Inject

class DefaultSurveyCoordinator: SurveyCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var surveyViewController: SurveyViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .survey
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.surveyViewController = SurveyViewController()

    }
    
    func start() {
        // ⚠️ Inject 사용중
        self.navigationController.pushViewController(Inject.ViewControllerHost(SurveyViewController()), animated: true)
    }
}

extension DefaultSurveyCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        // 자식 뷰를 삭제하는 델리게이트 (자식 -> 부모 접근 -> 부모에서 자식 삭제)
        self.childCoordinators = self.childCoordinators
            .filter({ $0.type != childCoordinator.type })
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
