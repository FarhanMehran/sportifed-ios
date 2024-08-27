//
//  SetPasswordRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/05/2024.
//

import Foundation

struct SetPasswordRequest: Codable{
    var otp:String
    var password:String
}
