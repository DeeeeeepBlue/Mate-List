//
//  AppCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/16.
//

import Foundation
import UIKit

import Utility

public class DefaultAppCoordinator: AppCoordinator {
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator]
    public var type: CoordinatorType
    
    required public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.type = CoordinatorType.home
    }
    
    public func start() {
        showTabBarFlow()
    }
    
    public func showTabBarFlow() {
        let tabBarCoordinator = DefaultTabBarCoordinator(self.navigationController)
        tabBarCoordinator.finishDelegate = self
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }

}

extension DefaultAppCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: Coordinator) {
        // 자식 뷰를 삭제하는 델리게이트 메모리에서 해제되도록 childCoordinators에서 삭제 후 pop
        self.childCoordinators = self.childCoordinators
            .filter({ $0.type != childCoordinator.type })
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
