//
//  TabBarCoordinator.swift
//  KuneFood
//
//  Created by Edwin Weru on 02/09/2021.
//

import UIKit


final class TabCoordinator: Coordinator {
    
    lazy var coordinator01 = CarsCoordinator(parentCoordinator: self)
    lazy var coordinator02 = FavoritesCoordinator(parentCoordinator: self)
    lazy var coordinator03 = NotificationsCoordinator(parentCoordinator: self)
    lazy var coordinator04 = MoreCoordinator(parentCoordinator: self)
    
    lazy var mainController: HomeViewController = {
        let vc = HomeViewController()

        vc.viewControllers = {
            var childViewControllers: [UIViewController] = []
            
            childViewControllers.append(coordinator01.primaryViewController())
            childViewControllers.append(coordinator02.primaryViewController())
            childViewControllers.append(coordinator03.primaryViewController())
            childViewControllers.append(coordinator04.primaryViewController())
            
            return childViewControllers
        }()

        return vc
    }()
    
    private func logout () {
        parentCoordinator?.dismiss()
        dismiss()
        
    }

    override func start() {
        let navController = BaseNavigationController(rootViewController: mainController)
        navController.modalPresentationStyle = .fullScreen
        
        navController.setNavigationBarHidden(true, animated: true)
        present(viewController: navController, animated: true)
        
        navigationController = navController
    }

    private func showHomeTab() {
        guard let index = mainController.viewControllers?.firstIndex(where: { $0 is CarsViewController }) else { return }
        mainController.selectedIndex = index
    }
}
