//
//  DefaultTabBarCoordinator.swift
//  MateList
//
//  Created by DOYEON LEE on 2022/12/18.
//

import Foundation
import UIKit

class DefaultTabBarCoordinator: TabBarCoordinator {
    
    var finishDelegate: CoordinatorFinishDelegate?
    var tabBarController: UITabBarController
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.type = CoordinatorType.tab
        // 탭바 생성
        self.tabBarController = UITabBarController()
    }
    
    
    /// 탭바 설정 함수들의 흐름 조정
    func start() {
        // 1. 탭바 아이템 리스트 생성
        let pages: [TabBarPage] = TabBarPage.allCases
        // 2. 탭바 아이템 생성
        let tabBarItems: [UITabBarItem] = pages.map { self.createTabBarItem(of: $0) }
        // 3. 탭바별 navigation controller 생성
        let controllers: [UINavigationController] = tabBarItems.map {
            self.createTabNavigationController(tabBarItem: $0)
        }
        // 4. 탭바별로 코디네이터 생성하기
        let _ = controllers.map{ self.startTabCoordinator(tabNavigationController: $0) }
        // 5. 탭바 스타일 지정 및 화면에 붙이기
        self.configureTabBarController(with: controllers)
    }

    // MARK: - 페이지 기능
    
    /// 현재 페이지 가져오기
    func getCurrentPage() -> TabBarPage? {
        return TabBarPage(index: self.tabBarController.selectedIndex)
    }
    
    /// TabBarPage형으로 탭바 페이지 변경
    func selectPage(_ page: TabBarPage) {
        self.tabBarController.selectedIndex = page.toInt()
    }

    /// Int형으로 탭바 페이지 변경
    func setSelectedIndex(_ index: Int) {
        guard TabBarPage(index: index) != nil else { return }
        self.tabBarController.selectedIndex = index
    }

    // MARK: - 탭바 설정 메소드
    
    /// 탭바 스타일 지정 및 초기화
    private func configureTabBarController(with tabViewControllers: [UIViewController]) {
        // TabBar의 VC 지정
        self.tabBarController.setViewControllers(tabViewControllers, animated: true)
        // home의 index로 TabBar Index 세팅
        self.tabBarController.selectedIndex = TabBarPage.home.toInt()
        // TabBar 스타일 지정
        self.tabBarController.view.backgroundColor = .systemBackground
        self.tabBarController.tabBar.backgroundColor = .systemBackground
        self.tabBarController.tabBar.tintColor = UIColor.black
        
        // VC 붙이기
        self.navigationController.pushViewController(self.tabBarController, animated: true)
    }
    
    /// 탭바 아이템 생성
    private func createTabBarItem(of page: TabBarPage) -> UITabBarItem {
        return UITabBarItem(
            title: page.toKrName(),
            image: UIImage(systemName: page.toIconName()),
            tag: page.toInt()
        )
    }

    /// 탭바 페이지대로 탭바 생성
    private func createTabNavigationController(tabBarItem: UITabBarItem) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        tabNavigationController.navigationBar.topItem?.title = TabBarPage(index: tabBarItem.tag)?.toKrName()
        tabNavigationController.tabBarItem = tabBarItem

        return tabNavigationController
    }
    
    private func startTabCoordinator(tabNavigationController: UINavigationController) {
        // tag 번호로 TabBarPage로 변경
        let tabBarItemTag: Int = tabNavigationController.tabBarItem.tag
        guard let tabBarPage: TabBarPage = TabBarPage(index: tabBarItemTag) else { return }
        
        // 코디네이터 생성 및 실행
        switch tabBarPage {
        case .home:
            let homeCoordinator = DefaultHomeCoordinator(tabNavigationController)
            homeCoordinator.finishDelegate = self
            self.childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
        case .scrap:
            let scrapCoordinator = DefaultScrapCoordinator(tabNavigationController)
            scrapCoordinator.finishDelegate = self
            self.childCoordinators.append(scrapCoordinator)
            scrapCoordinator.start()
        case .info:
            let infoCoordinator = DefaultInfoCoordinator(tabNavigationController)
            infoCoordinator.finishDelegate = self
            self.childCoordinators.append(infoCoordinator)
            infoCoordinator.start()
        }
    }
}

extension DefaultTabBarCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        self.navigationController.viewControllers.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
