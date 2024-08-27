//
//  GetSportsResponce.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/05/2024.
//

import Foundation

// MARK: - GetSportsResponce
struct GetSportsResponce: Codable {
    var message: String?
    var data: [SportsData]?
}

// MARK: - Datum
struct SportsData: Codable ,Hashable{
    var id: Int?
    var name, createdAt, updatedAt: String?
    var isSelected:Bool? = false
    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
struct BaseResponce: Codable {
    var msg: String?
    var data: BaseDataClass?
}


struct BaseDataClass: Codable {
  
}
