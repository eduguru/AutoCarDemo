//
//  WalkthroughCoordinator.swift
//  KuneFood
//
//  Created by Edwin Weru on 02/09/2021.
//

import Foundation
import UIKit

class WalkthroughCoordinator: Coordinator {
      
    deinit {
        print("LoginCoordinator deinit")
    }
    
    override func start() {
        
        let vc = WalkthroughViewController()
        
        vc.goToMain = showMainFlow
        push(viewController: vc)
    }
    
    func showMainFlow() {
        // Implement Main (Tab bar) FLow
        let tabCoordinator = TabCoordinator(parentCoordinator: self)
        tabCoordinator.start()
    }
    
//    func showMainFlow() {
//        // Implement Main (Tab bar) FLow
//        let coordinator = TabCoordinator.init(navigationController)
//        coordinator.start()
//        childCoordinators.append(coordinator)
//    }
}
