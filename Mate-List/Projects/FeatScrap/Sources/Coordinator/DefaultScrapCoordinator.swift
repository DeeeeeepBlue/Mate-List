//
//  DefaultScrapCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/29.
//

import Foundation
import UIKit

import Utility

public class DefaultScrapCoordinator: Coordinator{
    
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType = .scrap
    var scrapViewController: ScrapViewController
    
    required public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.scrapViewController = ScrapViewController()
       
    }
    
    public func start() {
        self.navigationController.pushViewController(self.scrapViewController, animated: true)
    }
}

extension DefaultScrapCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: Coordinator) {
        // 자식 뷰를 삭제하는 델리게이트 (자식 -> 부모 접근 -> 부모에서 자식 삭제)
        self.childCoordinators = self.childCoordinators
            .filter({ $0.type != childCoordinator.type })
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
