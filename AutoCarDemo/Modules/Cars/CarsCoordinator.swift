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
        
        return vc
    }
    
}
