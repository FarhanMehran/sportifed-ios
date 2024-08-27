//
//  AuthenticationServices.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 08/05/2024.
//

import Foundation


protocol AuthenticationServiceable {
    
    func userLogin<T: Codable>(_ type: T.Type, request: AuthRequest) -> CommonResponse<T>
    func userSignup<T: Codable>(_ type: T.Type, request: AuthRequest) -> CommonResponse<T>
    func completeProfileRequest<T: Codable>(_ type: T.Type, request: CompleteProfileRequest) -> CommonResponse<T>
    func forgetPassword<T: Codable>(_ type: T.Type, request: ForgetPasswordRequest) -> CommonResponse<T>
    func setPassword<T: Codable>(_ type: T.Type, request: SetPasswordRequest) -> CommonResponse<T>
    func verifyProfile<T: Codable>(_ type: T.Type, request: VerifyProfileRequest) -> CommonResponse<T>
    func changePreference<T: Codable>(_ type: T.Type, request: ChangePreferenceRequest) -> CommonResponse<T>
    func updateUserProfile<T: Codable>(_ type: T.Type, request: UpdateUserProfileRequest) -> CommonResponse<T>
    func getPreference<T: Codable>(_ type: T.Type) -> CommonResponse<T>
    func getProfile<T: Codable>(_ type: T.Type) -> CommonResponse<T>
    func getSports<T: Codable>(_ type: T.Type) -> CommonResponse<T>
}

public class AuthenticationServices: AuthenticationServiceable {
    
    var networkRequest: Requestable
    
    public init(networkRequest: Requestable = NativeRequestable()) {
        self.networkRequest = networkRequest
    }
    
    func userLogin<T: Codable>(_ type: T.Type, request: AuthRequest) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.userLogin(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func userSignup<T: Codable>(_ type: T.Type, request: AuthRequest) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.userSignup(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func completeProfileRequest<T: Codable>(_ type: T.Type, request: CompleteProfileRequest) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.completeProfileRequest(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func forgetPassword<T: Codable>(_ type: T.Type, request: ForgetPasswordRequest) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.forgetPassword(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func setPassword<T: Codable>(_ type: T.Type, request: SetPasswordRequest) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.setPassword(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func verifyProfile<T: Codable>(_ type: T.Type, request: VerifyProfileRequest) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.verifyProfile(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func changePreference<T: Codable>(_ type: T.Type, request: ChangePreferenceRequest) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.changePreference(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func getPreference<T: Codable>(_ type: T.Type) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.getPreference
        return self.networkRequest.request(endpoint)
    }
    
    func getProfile<T: Codable>(_ type: T.Type) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.getProfile
        return self.networkRequest.request(endpoint)
    }
    
    func updateUserProfile<T: Codable>(_ type: T.Type, request: UpdateUserProfileRequest) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.updateUserProfile(request: request)
        return self.networkRequest.request(endpoint)
    }
    
    func getSports<T: Codable>(_ type: T.Type) -> CommonResponse<T> {
        let endpoint = AuthEndpoints.getSports
        return self.networkRequest.request(endpoint)
    }
}

