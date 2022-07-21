//
//  CarsApi.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import Moya

enum CarsApi {
    case getPopular(popular: Bool)
    case getAllCars(currentPage: Int, pageSize: Int)
    case getCarDetails(carId: String)
    case getCarMedia(carId: String)
}

extension CarsApi: TargetType {
    var baseURL: URL {
        let baseUrl: URL = URL(string: "https://api-prod.autochek.africa/v1/")!
        
        return baseUrl
    }
    
    var path: String {
        switch self {
        case .getPopular(_ ):
            return "inventory/make"
        case .getAllCars(_ , _):
            return "inventory/car/search"
        case .getCarDetails(carId: let carId):
            return "inventory/car/\(carId)"
        case .getCarMedia(_ ):
            return "inventory/car_media"
        }
    }
    
    var method: Method {
        switch self {
        case .getPopular(_ ):
            return .get
        case .getAllCars(_, _):
            return .get
        case .getCarDetails(_ ):
            return .get
        case .getCarMedia(_ ):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPopular(popular: let popular):
            var params: [String : Any] = [:]
            params["popular"] = popular
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getAllCars(currentPage: let currentPage, pageSize: let pageSize):
            var params: [String : Any] = [:]
            params["currentPage"] = currentPage
            params["pageSize"] = pageSize
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getCarDetails(_ ):
            let params: [String : String] = [:]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getCarMedia(carId: let carId):
            var params: [String : String] = [:]
            params["carId"] = carId
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let headers: [String : String] = [:]
        
        return headers
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
