//
//  FavoritesViewController.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(named: "tab-heart"),
            selectedImage: UIImage(named: "tab-heart")
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        navigationItem.title = "Favorite"
    }

}
