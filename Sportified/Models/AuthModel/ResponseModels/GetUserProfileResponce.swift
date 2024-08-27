//
//  GetUserProfile.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import Foundation
struct GetUserProfileResponce: Codable {
    var msg: String?
    var data: UserProfileData?
}

// MARK: - DataClass
struct UserProfileData: Codable {
    var id: Int?
    var role: String?
    var fullName, address, addressLat, addressLong: String?
    var verified, approved: Bool?
    var email, phoneNo, img: String?

    enum CodingKeys: String, CodingKey {
        case id, role
        case fullName = "full_name"
        case address
        case addressLat = "address_lat"
        case addressLong = "address_long"
        case verified, approved, email, phoneNo, img
    }
}
