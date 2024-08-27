//
//  UserDefaultsManager.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import Foundation
enum UserDefaultsKeys: String {
    case authTokenKey = "_AUTH_TOKEN_"
    case userType = "_USER_TYPE_"
    case loadOnboarding = "_ONBOARDING_VIEW_"
    case authRefreshTokenKey = "_AUTH_REFRESH_TOKEN_"
    case userProfileData = "-USER_PROFILE_DATA"
}

class UserDefaultsManager: ObservableObject {
    
    static let shared = UserDefaultsManager()
    let userDefaults = UserDefaults.standard

    ///UserDefault Keys
    @Published var authToken: String? {
        didSet {
            userDefaults.set(authToken, forKey: UserDefaultsKeys.authTokenKey.rawValue)
        }
    }
    
    @Published var loadOnboarding: Bool? {
        didSet {
            userDefaults.set(loadOnboarding, forKey: UserDefaultsKeys.loadOnboarding.rawValue)
        }
    }
    
    @Published var authRefreshTokenKey: String? {
        didSet {
            userDefaults.set(authRefreshTokenKey, forKey: UserDefaultsKeys.authRefreshTokenKey.rawValue)
        }
    }
    
    @Published var userProfileData: UserProfileData? {
        didSet {
            if let data = try? JSONEncoder().encode(userProfileData) {
                userDefaults.set(data, forKey: UserDefaultsKeys.userProfileData.rawValue)
            }
        }
    }
    
    init() {
        
        self.authToken = userDefaults.string(forKey: UserDefaultsKeys.authTokenKey.rawValue)
        self.loadOnboarding = userDefaults.bool(forKey: UserDefaultsKeys.loadOnboarding.rawValue)
        self.authRefreshTokenKey = userDefaults.string(forKey: UserDefaultsKeys.authRefreshTokenKey.rawValue)
        
        if let data = userDefaults.data(forKey: UserDefaultsKeys.userProfileData.rawValue),
           let model = try? JSONDecoder().decode(UserProfileData.self, from: data) {
            self.userProfileData = model
        }

    }
    
}
enum UserType: String, CaseIterable {
   case organize = "organiser"
   case user = "user"
}
