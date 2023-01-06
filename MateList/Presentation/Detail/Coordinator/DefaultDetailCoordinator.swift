//
//  DefaultDetailCoordinator.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import Foundation
import UIKit

class DefaultDetailCoordinator: DetailCoordinator {
    
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var detailViewController: DetailViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .detail
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.detailViewController = DetailViewController()
        // Usecase 주입
        
    }
    
    func start() {
        self.navigationController.pushViewController(self.detailViewController, animated: true)
    }
}

extension DefaultDetailCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({$0.type != childCoordinator.type})
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
