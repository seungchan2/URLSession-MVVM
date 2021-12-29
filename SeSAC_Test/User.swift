//
//  User.swift
//  SeSAC_Test
//
//  Created by 김승찬 on 2021/12/27.
//

import Foundation

// MARK: - User
struct User: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let username, email: String
}
