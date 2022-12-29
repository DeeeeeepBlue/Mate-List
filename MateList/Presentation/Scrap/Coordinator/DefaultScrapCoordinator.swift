//
//  DefaultScrapCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/29.
//

import Foundation
import UIKit

class DefaultScrapCoordinator{
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var scrapViewController: ScrapViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .home
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.scrapViewController = ScrapViewController()
    }
    
    func start() {
        self.navigationController.pushViewController(self.scrapViewController, animated: true)
    }
}

extension DefaultScrapCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        // 자식 뷰를 삭제하는 델리게이트 (자식 -> 부모 접근 -> 부모에서 자식 삭제)
        self.childCoordinators = self.childCoordinators
            .filter({ $0.type != childCoordinator.type })
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
