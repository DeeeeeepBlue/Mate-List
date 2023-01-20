//
//  CoordinatorFinishDelegate.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/23.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
