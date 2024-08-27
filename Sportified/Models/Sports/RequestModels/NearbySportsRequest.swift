//
//  NearbySportsRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 21/05/2024.
//

import Foundation

struct NearbySportsRequest: Codable{
    var lat: Double?
    var long: Double?
    var offset: Double?
    var limit: Double?
}
