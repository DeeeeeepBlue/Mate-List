//
//  DefaultDetailCoordinator.swift
//  MateList
//
//  Created by 강민규 on 2023/01/05.
//

import Foundation
import UIKit

class DefaultDetailCoordinatore: DetailCoordinator {
    
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
        
    }
    
    
}
