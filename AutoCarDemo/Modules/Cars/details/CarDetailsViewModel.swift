//
//  CarDetailsViewModel.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import RxSwift

class CarDetailsViewModel {
    
    var selected: Car?
    var carMediaSubject: BehaviorSubject = BehaviorSubject<[CarMedia]>(value: [])
    
    var bag: DisposeBag = DisposeBag()
    private var carService: CarsService = CarsService()
    
    init() {
        
    }
    
    func getCarMedia() -> BehaviorSubject<[CarMedia]> {
        guard let carId: String = selected?.id else {
            return carMediaSubject
        }
        
        carService.getCarMedia(carId: carId)
            .asObservable()
            .subscribe(
                onNext: { [weak self] res in
                    self?.carMediaSubject.onNext(res.carMediaList)
                    self?.carMediaSubject.onCompleted()
                },
                onError: { err in
                    print(err)
                    
                })
            .disposed(by: bag)
        
        return carMediaSubject
    }
    
}
