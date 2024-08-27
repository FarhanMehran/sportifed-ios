//
//  GetNearbyMatchesResponce.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 22/05/2024.
//

import Foundation

// MARK: - GetNearbyMatchesResponce
struct GetNearbyMatchesResponce: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [NearbyMatchesList]?
}

struct GetMatchesResponce: Codable {
    var msg:String?
    var data: [NearbyMatchesList]?
}

// MARK: - Result
   


struct User: Hashable,Codable {
    var id: Int?
    var fullName: String?
    var img: String? = "/media/banner/ball.png"
    var captain: String?
    var isSelected:Bool? = false
    enum CodingKeys: String, CodingKey {
        case id
        case img
        case fullName = "full_name"
    }
}
struct NearbyMatchesList:Hashable, Codable {
    var id: Int?
    var title, description, venue, venueLat: String?
    var venueLong: String?
    var gameDateTime: String?
    var gameAccess: GameAccess?
    var gameType: GameType?
    var skillRequired: SkillRequired?
    var playersLimit: Int?
    var byoe: Bool?
    var fee: String?
    var joinCode: String?
    var sportName: String?
    var createdAt, updatedAt: String?
    var sport: Int?
    var tournament: Int?
    var createdBy: Int?
    var users: [User]?
    var teams: [Team]?

    enum CodingKeys: String, CodingKey {
        case id, title, description, venue
        case venueLat = "venue_lat"
        case venueLong = "venue_long"
        case gameDateTime = "game_date_time"
        case gameAccess = "game_access"
        case gameType = "game_type"
        case skillRequired = "skill_required"
        case playersLimit = "players_limit"
        case byoe, fee
        case joinCode = "join_code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case sport, tournament
        case createdBy = "created_by"
        case sportName = "sport_name"
        case users, teams
    }
}

// MARK: - Team
struct Team:Hashable, Codable {
    var id: Int?
    var name, createdAt, updatedAt: String?
    var match: Int?
    var img: String?
    var captain: String?
    var users: [User]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case match, users
    }
}

enum GameAccess: String, Codable {
    case gameAccessPublic = "public"
    case invite = "invite"
}

enum GameType: String, Codable {
    case regular = "regular"
    case tournament = "tournament"
}

enum SkillRequired: String, Codable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case skillRequiredBeginner = "beginner"
}
enum Img: String, Codable {
    case mediaBannerBallPNG = "/media/banner/ball.png"
}
