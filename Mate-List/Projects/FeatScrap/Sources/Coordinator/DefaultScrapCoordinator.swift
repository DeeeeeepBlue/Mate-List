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
    var scrapViewController: ScrapViewController
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType = .home
    
    required public init(_ navigationController: UINavigationController) {
        // 아직 스토리보드로 작동중이라 다음 코드 사용
        self.navigationController = navigationController
        //        self.scrapViewController = ScrapViewController()
        self.scrapViewController = UIStoryboard(name: "Scrap", bundle: nil)
            .instantiateViewController(withIdentifier: "scrapStoryboard") as! ScrapViewController
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
