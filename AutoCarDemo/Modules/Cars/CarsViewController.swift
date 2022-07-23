//
//  CarsViewController.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit
import RxCocoa
import RxSwift

class CarsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedCar: (Car) -> Void = { _ in }
    var viewModel: CarsViewModel!
    
    let disposeBag = DisposeBag()
    var cars: [Car] = []
    var popularCars: [PopularCar] = []
    var categories: [Category] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "tab-home"),
            selectedImage: UIImage(named: "tab-home")
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        let searchBar = self.navigationItem.searchController!.searchBar
        
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(2000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            //.filter({$0.count > 2})
            .subscribe(onNext: { [weak self] search in
                print(search, Date())
                //self?.childController.searchSubject.accept(search)
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned searchBar] in
                searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned searchBar] in
                searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)

        
        initiateNetworkCall()
        setUpTableView()
    }
    
}

extension CarsViewController {
    //MARK: - Helper Method
    
    private func setupNavigationBar() {
        
        title = "Explore"
        self.navigationItem.title = "Explore"
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let tile = UIBarButtonItem(image: UIImage(named: "ic-tile"), style: .plain, target: self, action: #selector(tileAction))
        let cart = UIBarButtonItem(image: UIImage(named: "tab-shopping-bag"), style: .plain, target: self, action: #selector(cartAction))
        self.navigationItem.setRightBarButtonItems([cart], animated: true)
        self.navigationItem.setLeftBarButtonItems([tile], animated: true)
    }
    
    @objc func cartAction() {
        
    }
    
    @objc func tileAction() {
        
    }
    
    private func setUpTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        
        tableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableView.register(HomeCarTableViewCell.nib(), forCellReuseIdentifier: HomeCarTableViewCell.reuseIdentifier)
        
        tableView.reloadData()
    }
    
    private func initiateNetworkCall() {
        viewModel.getAll()
            .asObserver()
            .subscribe(onNext: { [weak self] arr in
                self?.cars = arr
                self?.tableView.reloadData()
            }, onError: { err in
                print(err)
            })
            .disposed(by: disposeBag)
        
        
        
        do {
            categories = try! viewModel.categories.value()
            print(categories)
        } catch(let error){
            print(error)
        }
    }
}

//MARK: - UICollectionViewDataSource Methods
extension CarsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? CGFloat(160) : CGFloat(300)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            
            cell.arrayList = categories
            cell.collectionView.reloadData()
            
            return cell
        } else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCarTableViewCell.reuseIdentifier) as? HomeCarTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .clear
            cell.configure(with: cars[indexPath.row])
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 1 else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let item: Car = cars[row]
        selectedCar(item)
    }
    
}
