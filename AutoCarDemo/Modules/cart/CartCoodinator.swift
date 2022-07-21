//
//  CartCoodinator.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit

class CartCoodinator: Coordinator {
    
    func primaryViewController() -> CartItemsViewController {
        let vc = CartItemsViewController()
        //let model = LifestyleViewModel()
        
        return vc
    }
    
}
