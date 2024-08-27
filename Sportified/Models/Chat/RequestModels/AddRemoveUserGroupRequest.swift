//
//  AddRemoveUserGroupRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 12/07/2024.
//

import Foundation
struct RemoveUserFromGroupRequest: Codable{
    var chat_id: Int?
    var user_id: Int?
    var action: Bool?
}

struct MakeCaptainRequest: Codable{
    var team_id: Int?
    var user_id: Int?
}
