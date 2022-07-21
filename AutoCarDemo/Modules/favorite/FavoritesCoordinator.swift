//
//  FavoritesCoordinator.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    
    func primaryViewController() -> FavoritesViewController {
        let vc = FavoritesViewController()
        //let model = LifestyleViewModel()
        
        return vc
    }
    
}
