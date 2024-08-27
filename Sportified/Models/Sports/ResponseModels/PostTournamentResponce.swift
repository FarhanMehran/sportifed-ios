//
//  PostTournamentResponce.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import Foundation

struct PostTournamentResponce: Codable {
    var msg: String?
    var data: NearbyMatchesList?
}

// MARK: - DataClass
struct PostTournamentData: Codable {
    var id: Int?
    var title, description, skillRequired, gameAccess: String?
    var playersLimit: Int?
    var byoe: Bool?
    var fee: String?
    var joinCode: String?
    var createdAt, updatedAt: String?
    var sport, createdBy: Int?
    var users: [User]?
    var teams: [Team]?

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case skillRequired = "skill_required"
        case gameAccess = "game_access"
        case playersLimit = "players_limit"
        case byoe, fee
        case joinCode = "join_code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case sport
        case createdBy = "created_by"
        case users
    }
}
