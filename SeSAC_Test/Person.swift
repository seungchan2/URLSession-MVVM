//
//  Person.swift
//  SeSAC_Test
//
//  Created by 김승찬 on 2021/12/28.
//

import Foundation

struct Person: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let knownForDepartment, name: String
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
    }
}
