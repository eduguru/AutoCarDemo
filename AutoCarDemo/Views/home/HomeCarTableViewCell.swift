//
//  HomeCarTableViewCell.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 22/07/2022.
//

import UIKit
import Kingfisher

class HomeCarTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    
    @IBOutlet private weak var img_logo: UIImageView!
    @IBOutlet private weak var img_rating: UIImageView! {
        didSet {
            img_rating.tintColor = .colorPrimary
        }
    }
    
    @IBOutlet private weak var lbl_model: UILabel!
    @IBOutlet private weak var lbl_make: UILabel!
    @IBOutlet private weak var lbl_price: UILabel!
    @IBOutlet private weak var lbl_rating: UILabel!
    
    @IBOutlet private weak var btn_favorite: UIButton! {
        didSet {
            btn_favorite.tintColor = .red
        }
    }
    @IBOutlet private weak var btn_add: UIButton! {
        didSet {
            btn_add.tintColor = .colorPrimary
        }
    }
    
    static let reuseIdentifier = "HomeCarTableViewCell"
    
    static func nib() ->UINib {
        return UINib(nibName: "HomeCarTableViewCell", bundle: nil)
    }
    
    func configure(with viewModel: Car) {
        
        lbl_model.text = viewModel.title
        lbl_make.text = viewModel.fuelType
        lbl_price.text = "\(viewModel.marketplacePrice)"
        lbl_rating.text = String(format: "%.2f", viewModel.gradeScore)
        
        guard let imgUrl: URL = URL(string: viewModel.imageUrl) else {
            return
        }
        
        img_logo?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: ""),
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
        bgView.cornerRadius = 15
        img_logo.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
