//
//  MatchWithoutTournamentRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import Foundation

struct MatchWithoutTournamentRequest: Codable {
    var title, description, venue: String?
    var sport: Int?
    var venueLat, venueLong, gameDateTime, gameAccess: String?
    var skillRequired, playersLimit: String?,tournament:Int?
    var byoe: Bool?
    var fee: String?
    var team1:String?
    var team2:String?
    var id:Int?

    enum CodingKeys: String, CodingKey {
        case title, description, venue, sport,tournament
        case venueLat = "venue_lat"
        case venueLong = "venue_long"
        case gameDateTime = "game_date_time"
        case gameAccess = "game_access"
        case skillRequired = "skill_required"
        case playersLimit = "players_limit"
        case byoe, fee,team1,team2,id
    }
}

