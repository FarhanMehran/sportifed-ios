//
//  Enumeration.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import Foundation
enum Tab:String,CaseIterable {
    
    case home
    case games
    case communities
    case account


    var title:String {
        switch self {
        case .home:
            return "Home"
        case .games:
            return "games"
        case .communities:
            return "Communities"
        case .account:
            return "Account"
        }
    }

    var defaultImage:String {
        switch self {
        case .home:
            return "Home"
        case .games:
            return "game"
        case .communities:
            return "Communities"
        case .account:
            return "account"
        }
    }

    var selectedImage:String {
        switch self {
        case .home:
            return "Home_Fill"
        case .games:
            return "game_Fill"
        case .communities:
            return "Communities_Fill"
        case .account:
            return "account_Fill"
        }
    }

}

//Chat tpes
enum ChatUserype{
    case ownUser
    case community
    case organizer
}

enum ToastType: String {
    case success = "appGreen"
    case error = "appRed"
    case warning = "Yellow"
    case normal = "no"
}
