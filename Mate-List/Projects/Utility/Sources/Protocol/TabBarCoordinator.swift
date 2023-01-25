//
//  TabBarCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/18.
//

import Foundation
import UIKit

public protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController { get set }
    func selectPage(_ page: TabBarItemType)
    func setSelectedIndex(_ index: Int)
    func getCurrentPage() -> TabBarItemType?
}
