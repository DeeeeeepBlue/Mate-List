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
    var type: CoordinatorType = .home
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.homeViewController = HomeViewController()
        // Usecase 주입
        homeViewController.viewModel = HomeViewModel(coordinator: self,
                                                     homeUseCase: HomeDefaultUseCase(
                                                        firestoreRepository: DefaultFirestoreRepository()
                                                        )
                                                    )
    }
    
    func start() {
        self.navigationController.pushViewController(self.homeViewController, animated: true)
    }
    
    func showDetailFlow() {
        let detailCoordinator = DefaultDetailCoordinator(self.navigationController)
        detailCoordinator.finishDelegate = self
        self.childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
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
