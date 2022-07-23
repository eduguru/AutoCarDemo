//
//  CarListResponse.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import Foundation

struct CarListResponse: Codable {
    let result: [Car]
    let pagination: Pagination
}

struct Car: Codable {
    let id: String
    let title: String
    let imageUrl: String
    let year: Int
    let city: String
    let state: String
    let gradeScore: Double
    let sellingCondition: String
    let hasWarranty: Bool
    let marketplacePrice: Int
    let marketplaceOldPrice: Int
    let hasFinancing: Bool
    let mileage: Int
    let mileageUnit: String
    let installment: Int
    let depositReceived: Bool
    let loanValue: Int
    let websiteUrl: String
    let stats: Stats
    let bodyTypeId: String
    let sold: Bool
    let hasThreeDImage: Bool
    let transmission: String
    let fuelType: String
    let marketplaceVisibleDate: String
}

struct Stats: Codable {
    let webViewCount: Int
    let webViewerCount: Int
    let interestCount: Int
    let testDriveCount: Int
    let appViewCount: Int
    let appViewerCount: Int
    let processedLoanCount: Int
    
}
