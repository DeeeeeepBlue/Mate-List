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
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .detail
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        // Usecase 주입
        
    }
    func start() { }
    
    func start(with postData: Post?) {
        guard let postData = postData else { return }
        var detailViewController = DetailViewController()
        detailViewController.viewModel = DetailViewModel(detailUseCase: createUseCase(with: postData))
        
        detailViewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func createUseCase(with postData: Post) -> DefaultDetailUseCase {
        return DefaultDetailUseCase(post: postData)
    }
}

extension DefaultDetailCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({$0.type != childCoordinator.type})
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
