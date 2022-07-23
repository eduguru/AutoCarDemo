//
//  CategoryTableViewCell.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 22/07/2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static let reuseIdentifier = "CategoryTableViewCell"
    
    static func nib() ->UINib {
        return UINib(nibName: "CategoryTableViewCell", bundle: nil)
    }
    
    var arrayList: [Category] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCollectionViewCell.nib(), forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier, for: indexPath) as?  MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: arrayList[indexPath.item])
        
        return cell
    }
    
    
}
