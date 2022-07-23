//
//  CarsCoordinator.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit

class CarsCoordinator: Coordinator {
    
    func primaryViewController() -> UIViewController {
        
        let vc = CarsViewController()
        let model = CarsViewModel()
        vc.viewModel = model
        
        vc.selectedCar = goToDetails
        
        let navC = BaseNavigationController(rootViewController: vc)
        navigationController = navC
        return navC
    }
    
    
    private func goToDetails(selected: Car) {
        let viewModel = CarDetailsViewModel()
        let vc = CarDetailsViewController()
        let navC = BaseNavigationController(rootViewController: vc)
        navC.modalPresentationStyle = .fullScreen
        
        viewModel.selected = selected
        vc.viewModel = viewModel
        
        vc.backAction = dismissView
        present(viewController: navC)
    }
    
    private func dismissView() {
        dismiss()
    }
    
    private func popView() {
        dismiss()
    }
}
