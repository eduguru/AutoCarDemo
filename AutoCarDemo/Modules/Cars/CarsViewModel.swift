//
//  CarViewModel.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import RxSwift

class CarsViewModel {
    
    static let shared = CarsViewModel()
    
    private var cars: BehaviorSubject = BehaviorSubject<[Car]>(value: [])
    private var popularCars: BehaviorSubject = BehaviorSubject<[PopularCar]>(value: [])
    var categories: BehaviorSubject = BehaviorSubject<[Category]>(value: [])
    
    
    var bag: DisposeBag = DisposeBag()
    private var carService: CarsService = CarsService()
    
    init() {
        categories.onNext([
        Category(id: 0, title: "nissan", image: "nissan"),
        Category(id: 0, title: "vw", image: "vw"),
        Category(id: 0, title: "Toyota", image: "toyota"),
        Category(id: 0, title: "volvo", image: "volvo"),
        Category(id: 0, title: "mercedes", image: "mercedes")
        ])
    }
    
    func getAll() -> BehaviorSubject<[Car]> {
        carService.getAllCars(currentPage: 1, pageSize: 20)
            .asObservable()
            .subscribe(
                onNext: { [weak self] res in
                    self?.cars.onNext(res.result)
                    self?.cars.onCompleted()
                },
                onError: { err in
                    print("err", err)
                },
                onCompleted: {
                    
                },
                onDisposed: {
                    
                })
            .disposed(by: bag)
        
        return cars
    }
    
    func getPopular(popular: Bool = true) -> BehaviorSubject<[PopularCar]>  {
        carService.getPopular(popular: popular)
            .asObservable()
            .subscribe(
                onNext: { [weak self] res in
                    self?.popularCars.onNext(res.makeList)
                    self?.popularCars.onCompleted()
                },
                onError: { err in
                    print("err", err)
                },
                onCompleted: {
                    
                },
                onDisposed: {
                    
                })
            .disposed(by: bag)
        
        return popularCars
    }
    
}
