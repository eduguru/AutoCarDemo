//
//  CarMediaResponse.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import Foundation

struct CarMediaResponse: Codable {
    let carMediaList:[CarMedia]
    let pagination: Pagination
}

struct CarMedia: Codable {
    let id: Int
    let name: String
    let url: String
    let createdAt: String
    let type: String
}
