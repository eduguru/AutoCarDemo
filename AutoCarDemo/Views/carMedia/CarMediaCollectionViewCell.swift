//
//  CarMediaCollectionViewCell.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 23/07/2022.
//

import UIKit
import Kingfisher

class CarMediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img_view: UIImageView!
    
    @IBOutlet weak var btn_play: UIButton!
    
    static let reuseIdentifier = "CarMediaCollectionViewCell"
    
    static func nib() ->UINib {
        return UINib(nibName: "CarMediaCollectionViewCell", bundle: nil)
    }
    
    func configure(with viewModel: CarMedia) {
        
        guard let imgUrl: URL = URL(string: viewModel.url), viewModel.type == "image" else {
            btn_play.isHidden = false
            return
        }
        
        btn_play.isHidden = true
        img_view?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "vehicle-placeholder"),
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
