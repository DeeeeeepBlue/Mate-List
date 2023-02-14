//
//  HomeCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/18.
//

import Foundation
import UIKit

import Utility
import Service
//import FeatSurvey
import FeatDetail

public class DefaultHomeCoordinator: HomeCoordinator {
    
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var homeViewController: HomeViewController
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType = .home
    
    required public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.homeViewController = HomeViewController()
        // Usecase 주입
        homeViewController.viewModel = HomeViewModel(coordinator: self,
                                                     homeUseCase: HomeDefaultUseCase(
                                                        firestoreRepository: DefaultFirestoreRepository()
                                                        )
                                                    )
    }
    
    public func start() {
        self.navigationController.pushViewController(self.homeViewController, animated: true)
    }
    

    // ⚠️ 임시
    public func startSurveyFlow(){
//        let surveyCoordinator = DefaultSurveyCoordinator(self.navigationController)
//        surveyCoordinator.finishDelegate = self
//        self.childCoordinators.append(surveyCoordinator)
//        surveyCoordinator.start()
    }

    public func showDetailFlow(postData: Post?) {
        let detailCoordinator = DefaultDetailCoordinator(self.navigationController)
        detailCoordinator.finishDelegate = self
        self.childCoordinators.append(detailCoordinator)
        detailCoordinator.start(with: postData)
    }

}

extension DefaultHomeCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: Coordinator) {
        // 자식 뷰를 삭제하는 델리게이트 (자식 -> 부모 접근 -> 부모에서 자식 삭제)
        self.childCoordinators = self.childCoordinators
            .filter({ $0.type != childCoordinator.type })
        childCoordinator.navigationController.popToRootViewController(animated: true)
    }
}
