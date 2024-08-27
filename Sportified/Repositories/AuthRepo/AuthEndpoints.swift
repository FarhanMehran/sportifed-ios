//
//  AuthEndpoints.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/05/2024.
//

import Foundation

enum AuthEndpoints: NetworkRequtable {
    
    case userLogin(request: AuthRequest)
    case userSignup(request: AuthRequest)
    case completeProfileRequest(request: CompleteProfileRequest)
    case forgetPassword(request: ForgetPasswordRequest)
    case setPassword(request: SetPasswordRequest)
    case verifyProfile(request: VerifyProfileRequest)
    case changePreference(request: ChangePreferenceRequest)
    case updateUserProfile(request: UpdateUserProfileRequest)
    case getPreference
    case getProfile
    case getSports
   
    var url: String {
        let baseUrl = NetworkConfiguration.shared.getBaseURL()
        switch self {
        case .userLogin:
            return baseUrl.appending("auth/login/")
        case .userSignup:
            return baseUrl.appending("auth/signup/")
        case .completeProfileRequest:
            return baseUrl.appending("auth/complete_profile/")
        case .forgetPassword:
            return baseUrl.appending("auth/otp_request/")
        case .setPassword:
            return baseUrl.appending("auth/setpassword/")
        case .verifyProfile:
            return baseUrl.appending("auth/verify_profile/")
        case .getPreference:
            return baseUrl.appending("auth/get_preference/")
        case .changePreference:
            return baseUrl.appending("auth/change_favsports/")
        case .getProfile:
            return baseUrl.appending("auth/get_profile/")
        case .updateUserProfile:
            return baseUrl.appending("auth/update_profile/")
        case .getSports:
            return baseUrl.appending("sports/sports/")
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .userLogin, .userSignup, .completeProfileRequest, .forgetPassword, .setPassword, .getPreference, .verifyProfile
            , .changePreference, .getProfile, .getSports, .updateUserProfile:
            return [:]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .userLogin, .userSignup, .completeProfileRequest, .forgetPassword, .setPassword, .verifyProfile, .changePreference, .updateUserProfile:
            return .POST
            
        case .getPreference, .getProfile, .getSports:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .userLogin(let AuthRequest), .userSignup(let AuthRequest):
            return AuthRequest.encode()
        case .completeProfileRequest(let CompleteProfileRequest):
            return CompleteProfileRequest.encode()
        case .forgetPassword(let ForgetPasswordRequest):
            return ForgetPasswordRequest.encode()
        case .setPassword(let SetPasswordRequest):
            return SetPasswordRequest.encode()
        case .verifyProfile(let VerifyProfileRequest):
            return VerifyProfileRequest.encode()
        case .changePreference(let VerifyProfileRequest):
            return VerifyProfileRequest.encode()
        case .updateUserProfile(let UpdateUserProfileRequest):
            return UpdateUserProfileRequest.encode()
        case .getPreference, .getProfile, .getSports:
            return nil
        }
  
    }
    
}


