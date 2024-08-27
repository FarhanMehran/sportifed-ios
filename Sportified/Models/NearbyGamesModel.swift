//
//  NearbyGamesModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import Foundation

struct NearbyGamesModel{
    var showButton = true
    var users = "4"
    var players = "4"
    var date = "Mon 11 Jun, 5:45 PM "
    var match = "Golf Tournament"
    var fee = "AED 50"
    var loction = "Golf Sports Academy, Dubai, UAE ~ 05.56 kms"
}

//MARK: - RegionCountryCode
struct RegionCountryCode: Codable {
    var name, flag, code, dialCode: String?

    enum CodingKeys: String, CodingKey {
        case name, flag, code
        case dialCode = "dial_code"
    }
}
