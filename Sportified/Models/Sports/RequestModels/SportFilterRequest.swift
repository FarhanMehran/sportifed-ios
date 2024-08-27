//
//  SportFilterRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import Foundation

struct SportFilterRequest: Codable {
    var sport_id: Int?
    var limit: Int?
    var lat: Double?
    var long: Double?
    var offset: Int?
    var tournament_id: Int?
    var match_id: Int?
    var chat_id: Int?
    
    func makeRequestParam() -> [String: String] {
        var params: [String: String] = [:]
        
        if let sport_id = sport_id {
            params["sport_id"] = "\(sport_id)"
        }
        
        if let offset = offset {
            params["offset"] = "\(offset)"
        }
        
        if let limit = limit {
            params["limit"] = "\(limit)"
        }
        
        if let tournament_id = tournament_id {
            params["tournament_id"] = "\(tournament_id)"
        }
        
        if let match_id = match_id {
            params["match_id"] = "\(match_id)"
        }
        
        if let lat = lat {
            params["lat"] = "\(lat)"
        }
        
        if let long = long {
            params["long"] = "\(long)"
        }
        
        if let chat_id = chat_id {
            params["chat_id"] = "\(chat_id)"
        }
        
        return params
    }
}

