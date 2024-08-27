//
//  GetPreferenceResponce.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/05/2024.
//

import Foundation

// MARK: - GetPreferenceResponce
struct GetPreferenceResponce: Codable {
    var msg: String?
    var data: PreferenceDataClass?
}

// MARK: - DataClass
struct PreferenceDataClass: Codable {
    var id: Int?
    var fullName, address, addressLat, addressLong: String?
    var sports: [Sport]?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case address
        case addressLat = "address_lat"
        case addressLong = "address_long"
        case sports
    }
}

// MARK: - Sport
struct Sport: Codable {
    var id: Int?
    var name: String?
    var userFav: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case userFav = "user_fav"
    }
}


