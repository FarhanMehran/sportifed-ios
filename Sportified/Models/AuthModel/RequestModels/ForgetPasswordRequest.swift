//
//  ForgetPasswordRequest.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/05/2024.
//

import Foundation

struct ForgetPasswordRequest: Codable{
    var email:String
}

struct ForgetPasswordRespone: Codable{
    var msg:String
}
