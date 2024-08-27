//
//  LoginResponse.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/05/2024.
//

import Foundation

struct LoginResponse: Codable {
    var msg: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var refreshToken, accessToken, refreshTokenExpiry, accessTokenExpiry, role: String?
    var approved, verified: Bool?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case refreshTokenExpiry = "refresh_token_expiry"
        case accessTokenExpiry = "access_token_expiry"
        case approved, verified, id
    }
}
