//
//  CarsCoordinator.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit

class CarsCoordinator: Coordinator {
    
    func primaryViewController() -> CarsViewController {
        let vc = CarsViewController()
        let model = CarsViewModel()
        vc.viewModel = model
        
        vc.selectedCar = goToDetails
        
        return vc
    }
    
    
    private func goToDetails(selected: Car) {
        let vc = CarDetailsViewController()
        push(viewController: vc)
    }
}
