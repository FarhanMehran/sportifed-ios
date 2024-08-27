//
//  joinPublicMatchRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/05/2024.
//

import Foundation

struct joinPublicMatchRequest: Codable{
    
    var match_id: Int?
    var join_code: String?
    var team: String?
  
}

