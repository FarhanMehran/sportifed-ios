//
//  GetAllUserResponce.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 11/07/2024.
//

import Foundation
struct GetAllUserResponce: Codable,Hashable {
    var message: String?
    var data: [GetUserData]?
}
struct GetUserData: Codable,Hashable {
    var id: Int?
    var role: String?
    var name: String?
    var phoneNo: String?
    var img: String?
    var isSelected: Bool? = false
    enum CodingKeys: String, CodingKey {
        case id,phoneNo,img
        case name = "full_name"
    }
}

// MARK: - AttributesResponce
class GetAllChatsResponse: Codable {
    var count: Int?
    var next, previous: String?
    var results: [GetlCommunityResponce]?

    init(count: Int?, next: String?, previous: String?, results: [GetlCommunityResponce]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

