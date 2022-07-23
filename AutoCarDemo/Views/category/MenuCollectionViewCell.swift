//
//  MenuCollectionViewCell.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 22/07/2022.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var img_logo: UIImageView!
    @IBOutlet private weak var lbl_title: UILabel!
    
    static let reuseIdentifier = "MenuCollectionViewCell"
    
    static func nib() ->UINib {
        return UINib(nibName: "MenuCollectionViewCell", bundle: nil)
    }
    
    func configure(with viewModel: Category) {
        
        img_logo.image = UIImage(named:  viewModel.image)
        lbl_title.text = viewModel.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
