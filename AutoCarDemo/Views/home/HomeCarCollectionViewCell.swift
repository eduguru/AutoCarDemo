//
//  HomeCarCollectionViewCell.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 22/07/2022.
//

import UIKit

class HomeCarCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var img_logo: UIImageView!
    @IBOutlet private weak var img_rating: UIImageView!
    
    @IBOutlet private weak var lbl_model: UILabel!
    @IBOutlet private weak var lbl_make: UILabel!
    @IBOutlet private weak var lbl_price: UILabel!
    @IBOutlet private weak var lbl_rating: UILabel!
    
    @IBOutlet private weak var btn_favorite: UIButton!
    @IBOutlet private weak var btn_add: UIButton!
    
    static let reuseIdentifier = "HomeCarCollectionViewCell"
    
    static func nib() ->UINib {
        return UINib(nibName: "HomeCarCollectionViewCell", bundle: nil)
    }
    
    func configure(with viewModel: Car) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
