//
//  AppCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/16.
//

import Foundation
import UIKit

class DefaultAppCoordinator: AppCoordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    var type: CoordinatorType
    
    func start() {
        <#code#>
    }
    
    func showMainFlow() {
        <#code#>
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.type = CoordinatorType.home
    }
    
}
