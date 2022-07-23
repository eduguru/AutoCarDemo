//
//  Pagination.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import Foundation

struct Pagination: Codable {
    let total: Int
    let currentPage: Int
    let pageSize: Int
}
