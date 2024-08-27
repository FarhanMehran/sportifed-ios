//
//  CreatGroupRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/07/2024.
//

import Foundation

struct CreatGroupRequest: Codable{
    var name: String?
    var users: [Int]?
}


struct SendChatModel: Codable{
    var chat_id: Int?
    var message: String?
}
