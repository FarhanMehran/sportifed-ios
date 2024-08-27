//
//  OTPViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import Foundation

class OTPViewModel: BaseViewModel {
    
    var coordinator: AuthCoordinator?
    var dummyOTP = ""
    var userPhoneNumber = ""
    var routType:OTPRoutType = .forgetPassword
    @Published var password = ""
    @Published var otpCode: [String] =  Array(repeating: "", count: 4)
    @Published var otpField = ""{
        didSet {
            guard otpField.count <= 4,
                  otpField.last?.isNumber ?? true else {
                  otpField = oldValue
                return
            }
        }
    }
    
    func getOTPCode(index: Int) -> String {
        guard otpField.count >= (index + 1) else {
            return otpCode[index]
        }
        return String(Array(otpField)[index])
    }
    
    func btnVerify() {
        if otpField.count < 4{
            toastType = .warning
            validationText = "add otp"
            return
        }
        if routType == .forgetPassword{
            if password.isEmpty{
                toastType = .warning
                validationText = "add password"
                return
            }
            setPassword()
        }else{
            verifyProfile()
        }
    }
    
    func verifyProfile() {
       showActivityIndicator = true
        authService.verifyProfile(SignupResponse.self, request: VerifyProfileRequest(otp: otpField))
           .sink { [weak self] (completion) in
               switch completion {
               case .failure(let error):
                   guard let weakSelf = self else { return }
                   //this is for testing perpose
                   if error.msg == "User verified."{
                       weakSelf.coordinator?.loadHomeView()
                   }
                   weakSelf.validationText = error.msg ?? ""
                   weakSelf.showActivityIndicator = false
               default:
                   break
               }
           } receiveValue: { [weak self]  (response) in
               guard let weakSelf = self else { return }
               weakSelf.toastType = .success
               weakSelf.validationText = response.msg ?? ""
               DispatchQueue.main.async {
                   weakSelf.getUserProfile()
               }
               weakSelf.showActivityIndicator = false
           }
           .store(in: &cancellableSet)
   }
    
    func setPassword() {
       showActivityIndicator = true
        authService.setPassword(SignupResponse.self, request: SetPasswordRequest(otp: otpField, password: password))
           .sink { [weak self] (completion) in
               switch completion {
               case .failure(let error):
                   guard let weakSelf = self else { return }
                 
                   weakSelf.validationText = error.msg ?? ""
                   weakSelf.showActivityIndicator = false
               default:
                   break
               }
           } receiveValue: { [weak self]  (response) in
               guard let weakSelf = self else { return }
               weakSelf.validationText = response.msg ?? ""
               DispatchQueue.main.async {
                   weakSelf.coordinator?.loadLoginView()
               }
               weakSelf.showActivityIndicator = false
           }
           .store(in: &cancellableSet)
   }
    
    private func getUserProfile() {
        showActivityIndicator = true
        authService.getProfile(GetUserProfileResponce.self)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    guard let weakSelf = self else { return }
                    weakSelf.validationText = error.msg ?? ""
                    weakSelf.showActivityIndicator = false
                default:
                    break
                }
            } receiveValue: { [weak self]  (response) in
                guard let weakSelf = self else { return }
                UserDefaultsManager.shared.userProfileData = response.data
                weakSelf.coordinator?.loadHomeView()
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
}
