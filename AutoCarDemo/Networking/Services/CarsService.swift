//
//  CarsService.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import Moya
import RxSwift

protocol CarsServiceImpl {
    func getPopular(popular: Bool) -> Observable<PopularCarsResponse>
    func getAllCars(currentPage: Int, pageSize: Int) -> Observable<CarListResponse>
    func getCarMedia(carId: String) -> Observable<CarMediaResponse>
    //func getCarDetails(carId: String)
}

class CarsService: CarsServiceImpl {
    func getPopular(popular: Bool) -> Observable<PopularCarsResponse> {
        let provider = MoyaProvider<CarsApi>()
        
        return Observable<PopularCarsResponse>.create({ observer in
            
            provider.request(.getPopular(popular: popular)) { result in
                switch result {
                case .success(let response):
                    let data: String = String(data: response.data, encoding: .utf8) ?? ""
                    let decoder = JSONDecoder()
                    let jsonData: Data = Data(data.utf8)
                    
                    do {
                        let responseObject = try decoder.decode(PopularCarsResponse.self, from: jsonData)
                        
                        observer.onNext(responseObject)
                        observer.onCompleted()
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    func getAllCars(currentPage: Int, pageSize: Int) -> Observable<CarListResponse> {
        let provider = MoyaProvider<CarsApi>()
        
        return Observable<CarListResponse>.create({ observer in
            
            provider.request(.getAllCars(currentPage: currentPage, pageSize: pageSize)) { result in
                switch result {
                case .success(let response):
                    let data: String = String(data: response.data, encoding: .utf8) ?? ""
                    let decoder = JSONDecoder()
                    let jsonData: Data = Data(data.utf8)
                    
                    do {
                        let responseObject = try decoder.decode(CarListResponse.self, from: jsonData)
                        
                        observer.onNext(responseObject)
                        observer.onCompleted()
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    func getCarMedia(carId: String) -> Observable<CarMediaResponse> {
        let provider = MoyaProvider<CarsApi>()
        
        return Observable<CarMediaResponse>.create({ observer in
            
            provider.request(.getCarMedia(carId: carId)) { result in
                switch result {
                case .success(let response):
                    let data: String = String(data: response.data, encoding: .utf8) ?? ""
                    let decoder = JSONDecoder()
                    let jsonData: Data = Data(data.utf8)
                    
                    do {
                        let responseObject = try decoder.decode(CarMediaResponse.self, from: jsonData)
                        
                        observer.onNext(responseObject)
                        observer.onCompleted()
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
}
