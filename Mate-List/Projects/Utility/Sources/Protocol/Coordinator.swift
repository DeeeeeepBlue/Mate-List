//
//  Coordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/13.
//

// main
// develop
// feature
// feature/coordinator

import UIKit

public protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    init(_ navigationController: UINavigationController)
    func start()
    func finish()
    func findCoordinator(type: CoordinatorType) -> Coordinator?
}

public extension Coordinator {
    
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func findCoordinator(type: CoordinatorType) -> Coordinator? {
        var stack: [Coordinator] = [self]
        
        while !stack.isEmpty {
            let currentCoordinator = stack.removeLast()
            if currentCoordinator.type == type {
                return currentCoordinator
            }
            currentCoordinator.childCoordinators.forEach({ child in
                stack.append(child)
            })
        }
        return nil
    }
}
