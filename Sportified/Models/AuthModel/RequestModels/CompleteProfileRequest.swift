//
//  CompleteProfileRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/05/2024.
//

import Foundation

// MARK: - CompleteProfileRequest
struct CompleteProfileRequest: Codable {
    var fullName: String
    var favSports: [Int]
    var accountType, phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case favSports = "fav_sports"
        case accountType = "account_type"
        case phoneNumber = "phone_number"
    }
}
