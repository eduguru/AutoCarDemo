//
//  CarDetailsViewController.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import RxSwift
import RxCocoa

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
    @IBOutlet weak var lbl_counter: UILabel!
    
    @IBOutlet private weak var btn_done: UIButton! {
        didSet {
            btn_done.tintColor = .white
            btn_done.backgroundColor = .colorPrimary
            btn_done.setTitleColor(.white, for: .normal)
            btn_done.cornerRadius = 10
        }
    
    }
    
    var imageView: UIImageView?
    
    var disposeBag = DisposeBag()
    
    var arrayList: [CarMedia] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        configure(with: viewModel)
        
        btn_addItem.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        btn_remove.addTarget(self, action: #selector(removeAction), for: .touchUpInside)
        collectionView.backgroundColor = .white
        
        collectionView.register(CarMediaCollectionViewCell.nib(), forCellWithReuseIdentifier: CarMediaCollectionViewCell.reuseIdentifier)
        
        viewModel.getCarMedia()
            .asObserver()
            .bind(to: collectionView.rx.items(
                cellIdentifier: CarMediaCollectionViewCell.reuseIdentifier,
                cellType: CarMediaCollectionViewCell.self)
            ) { [weak self] row, item, cell in
                
                cell.backgroundColor = .clear
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(CarMedia.self)
            .subscribe(onNext: { [weak self] item in
                self?.appendMedia()
                self?.showMedia(with: item)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func cartAction() {
        
    }
    
    @objc func closeAction() {
        self.backAction()
    }
    
    @objc func addAction() {
        DispatchQueue.main.async {
            let counter = Int(self.lbl_counter.text ?? "0") ?? 0
            let itemcount = counter + 1
            self.lbl_counter.text = "\(abs(itemcount))"
        }
    }
    
    @objc func removeAction() {
        DispatchQueue.main.async {
            let counter = Int(self.lbl_counter.text ?? "0") ?? 0
            if counter > 0 {
                let itemcount = counter - 1
                self.lbl_counter.text = "\(abs(itemcount))"
            }
        }
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
        
    }
    
    private func appendMedia() {
        for view in self.contentPreview.subviews {
            view.removeFromSuperview()
        }
        
        createImageView()
    }
    
    private func createImageView() {
        imageView = UIImageView(frame: contentPreview.bounds);
        imageView?.image = UIImage(named:"image.jpg")
        imageView?.cornerRadius = 10
        imageView?.clipsToBounds = true
        imageView?.contentMode = .scaleAspectFit
        
        self.contentPreview.addSubview(imageView!)
    }
    
    private func showMedia(with viewModel: CarMedia) {
        
        guard let imgUrl: URL = URL(string: viewModel.url) else {
            return
        }
        
        imageView?.kf.setImage(
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
}
