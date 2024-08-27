//
//  NetworkConfiguration.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/05/2024.
//

import Foundation

public class NetworkConfiguration {
    
    static public let shared = NetworkConfiguration()
    
    lazy private var apiBaseURL: String = "http://3.83.13.164/"


    public func getBaseURL() -> String {
        return apiBaseURL
    }
}

struct NetworkConstant {
    enum HearderKeys: String {
        case authToken = "Authorization"
    }
    
    enum UserDefaultsKeys: String {
        case authTokenKey = "_AUTH_TOKEN_"
        case authRefreshTokenKey = "_AUTH_REFRESH_TOKEN_"
    }
}
