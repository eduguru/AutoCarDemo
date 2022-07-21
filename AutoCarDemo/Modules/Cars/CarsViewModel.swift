//
//  CarViewModel.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import RxSwift

class CarsViewModel {
    
    static let shared = CarsViewModel()
    
    var cars: BehaviorSubject = BehaviorSubject<[Car]>(value: [])
    
    var bag: DisposeBag = DisposeBag()
    private var carService: CarsService = CarsService()
    
    init() {
        
    }
    
    func getAll() {
        carService.getAllCars(currentPage: 1, pageSize: 20)
            .asObservable()
            .subscribe(
                onNext: { [weak self] res in
                    print("succ", res)
                },
                onError: {  [weak self] err in
                    print("err", err)
                },
                onCompleted: {
                    
                },
                onDisposed: {
                    
                })
            .disposed(by: bag)
    }
    
    func getPopular(popular: Bool = true) {
        print("wearegetting")
        carService.getPopular(popular: popular)
            .asObservable()
            .subscribe(
                onNext: { [weak self] res in
                    print("succ", res)
                },
                onError: {  [weak self] err in
                    print("err", err)
                },
                onCompleted: {
                    
                },
                onDisposed: {
                    
                })
            .disposed(by: bag)
    }
    
}
