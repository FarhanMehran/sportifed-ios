//
//  GetlCommunityResponce.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/06/2024.
//

import Foundation
struct GetlCommunityResponce: Codable {
    var id: Int?
    var name: String?
    var joined: Bool?
    var img, lastMessage, lastMessageTime: String?
    var showNotifection = false
    var unReadMessage = 0

    enum CodingKeys: String, CodingKey {
        case id, name, joined, img
        case lastMessage = "last_message"
        case lastMessageTime = "last_message_time"
    }
}
