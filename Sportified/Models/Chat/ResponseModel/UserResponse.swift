//
//  UserResponse.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/07/2024.
//

import Foundation
struct UserResponse: Codable,Hashable {
    var id: Int?
    var name: String?
    var isSelected: Bool? = false
}
