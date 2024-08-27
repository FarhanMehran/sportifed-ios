//
//  ForgetPasswordViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import Foundation

class ForgetPasswordViewModel: BaseViewModel {
    
    var coordinator: AuthCoordinator?
    @Published  var email:String = ""
   
    
    func btnForget(){
        
        if !Utility.isValidEmail(emailStr: email){
            toastType = .warning
            validationText = StringConstants.enterValidEmail
            return
        }
        forgetPasswordRequest(email: email)
    }
    
    //MARK: User ForgetPassword
     func forgetPasswordRequest(email: String) {
        showActivityIndicator = true
        authService.forgetPassword(ForgetPasswordRespone.self, request: ForgetPasswordRequest(email: email))
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
                weakSelf.coordinator?.loadOTPView(userPhoneNumber: weakSelf.email, dummyOTP: "", routType: .forgetPassword)
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
}
