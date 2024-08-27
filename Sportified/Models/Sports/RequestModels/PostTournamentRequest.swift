//
//  PostTournamentRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import Foundation

// MARK: - PostTournamentRequest
struct PostTournamentRequest: Codable {
    var title, description, venue: String?
    var sport: Int?
    var venueLat, venueLong, gameDateTime, gameAccess: String?
    var skillRequired: String?
    var tournament: Int?
    var playersLimit: String?
    var byoe: Bool?
    var fee: String?

    enum CodingKeys: String, CodingKey {
        case title, description, venue, sport
        case venueLat = "venue_lat"
        case venueLong = "venue_long"
        case gameDateTime = "game_date_time"
        case gameAccess = "game_access"
        case skillRequired = "skill_required"
        case tournament
        case playersLimit = "players_limit"
        case byoe, fee
    }
}
