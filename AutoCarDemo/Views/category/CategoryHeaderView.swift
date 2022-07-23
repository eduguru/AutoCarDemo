//
//  CategoryHeaderView.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 22/07/2022.
//

import Foundation
import UIKit

class CategoryHeaderView: UICollectionReusableView {
    
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Section Title"
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
