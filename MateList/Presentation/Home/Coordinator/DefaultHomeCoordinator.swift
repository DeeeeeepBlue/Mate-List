//
//  HomeCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/18.
//

import Foundation
import UIKit

class DefaultHomeCoordinator: HomeCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var homeViewController: HomeViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        // 디폴트 값으로 설정하면 안되나??
        self.homeViewController = HomeViewController()
        self.type = CoordinatorType.home
        
    }
    
    func start() {
        self.navigationController.pushViewController(self.homeViewController, animated: true)
    }
}

extension DefaultHomeCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        // 자식 뷰를 삭제하는 델리게이트 (자식 -> 부모 접근 -> 부모에서 자식 삭제)
        self.childCoordinators = self.childCoordinators
            .filter({ $0.type != childCoordinator.type })
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
