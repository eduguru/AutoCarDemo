//
//  CarDetailsViewController.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit

class CarDetailsViewController: UIViewController {

    var viewModel: CarDetailsViewModel!
    var backAction: () -> Void = { }
    
    @IBOutlet weak var btn_addItem: UIButton! {
        didSet {
            btn_addItem.backgroundColor = .colorPrimary
            btn_addItem.cornerRadius = 10
            btn_addItem.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBOutlet weak var btn_remove: UIButton! {
        didSet {
            btn_remove.tintColor = .colorPrimary
        }
    }
    
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.roundTopCorners(radius: 20)
            bottomView.backgroundColor = .lightText
        }
    }
    @IBOutlet weak var contentPreview: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet private weak var img_rating: UIImageView! {
        didSet {
            img_rating.tintColor = .colorPrimary
        }
    }
    
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet private weak var lbl_model: UILabel!
    @IBOutlet private weak var lbl_make: UILabel!
    @IBOutlet private weak var lbl_price: UILabel!
    @IBOutlet private weak var lbl_rating: UILabel!
    
    @IBOutlet private weak var btn_done: UIButton! {
        didSet {
            btn_done.tintColor = .white
            btn_done.backgroundColor = .colorPrimary
            btn_done.setTitleColor(.white, for: .normal)
            btn_done.cornerRadius = 10
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        configure(with: viewModel)
    }
    
    @objc func cartAction() {
        
    }
    
    @objc func closeAction() {
        self.backAction()
    }

}


extension CarDetailsViewController {
    
    private func setUpNavigation() {
        title = "Product"
        self.navigationItem.title = "Product"
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeAction))
        let cart = UIBarButtonItem(image: UIImage(named: "tab-shopping-bag"), style: .plain, target: self, action: #selector(cartAction))
        self.navigationItem.setRightBarButtonItems([cart], animated: true)
        self.navigationItem.setLeftBarButtonItems([closeButton], animated: true)
    }
    
    private func configure(with selected: CarDetailsViewModel) {
        
        guard let item = selected.selected else {
            return
        }
        
        lbl_title.text = item.title
        lbl_model.text = "Mileage: \(item.mileage) \(item.mileageUnit)"
        lbl_make.text = item.fuelType
        lbl_price.text = "\(item.marketplacePrice)"
        lbl_rating.text = String(format: "%.2f", item.gradeScore)
        
        guard let imgUrl: URL = URL(string: item.imageUrl) else {
            return
        }
        
//        img_logo?.kf.setImage(
//            with: imgUrl,
//            placeholder: UIImage(named: ""),
//            options: [
//                .loadDiskFileSynchronously,
//                .cacheOriginalImage,
//                .transition(.fade(0.25))
//            ],
//            progressBlock: { receivedSize, totalSize in
//                // Progress updated
//            },
//            completionHandler: { result in
//                // Done
//            }
//        )
        
    }
}
