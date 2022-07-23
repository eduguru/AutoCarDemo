//
//  PopularCarsResponse.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import Foundation

struct PopularCarsResponse: Codable {
    let makeList: [PopularCar]
    let pagination: Pagination
}
