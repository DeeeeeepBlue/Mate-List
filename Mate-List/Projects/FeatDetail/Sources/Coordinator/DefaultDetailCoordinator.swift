//
//  DefaultDetailCoordinator.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import Foundation
import UIKit

import Utility
import Service

public class DefaultDetailCoordinator: DetailCoordinator {
    
    
    public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType = .detail
    
    required public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        // Usecase 주입
        
    }
    
    public func start() {}
    public func start(with postData: Post?) {
        guard let postData = postData else { return }
        var detailViewController = DetailViewController()
        detailViewController.viewModel = DetailViewModel(detailUseCase: createUseCase(with: postData))
        
        detailViewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func createUseCase(with postData: Post) -> DefaultDetailUseCase {
        return DefaultDetailUseCase(post: postData, detailRepository: DetailRepository())
    }
}

extension DefaultDetailCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({$0.type != childCoordinator.type})
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
