//
//  LoginViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 01/05/2024.
//

import Foundation
class LoginViewModel: BaseViewModel{
    
    var coordinator: AuthCoordinator?
    
    @Published var signUpView = false
    @Published var showPassword = false
    @Published var txtEmail = ""
    @Published var txtPassword = ""
    @Published var title = StringConstants.signIn
    @Published var signUpWith = StringConstants.orSigninwith
    @Published var haveAccoutn = StringConstants.dontHaveanAccount
    
    
    
    func changeConfigationSignUpView(){
        signUpView.toggle()
        if signUpView {
            title = StringConstants.signUp
            signUpWith = StringConstants.orSignupWith
            haveAccoutn = StringConstants.alreadyHaveanAccount
        }else{
            title = StringConstants.signIn
            signUpWith = StringConstants.orSigninwith
            haveAccoutn = StringConstants.dontHaveanAccount
        }
    }
    
    //MARK: - Validate
    /**Logging user */
    func validationLogin() {
        
        if txtEmail.isEmpty || txtPassword.isEmpty {
            validationText = StringConstants.pleaseFillinAllTheFields
            toastType = .warning
            return
        }
        
        if !Utility.isValidEmail(emailStr: txtEmail){
            toastType = .warning
            validationText = StringConstants.enterValidEmail
            return
        }
        // User signUPRequest
        if signUpView{
            userSignupRequest(loginRequest: AuthRequest(email: txtEmail, password: txtPassword))
        }else {
            // User LoginRequest
            userLoginRequest(loginRequest: AuthRequest(email: txtEmail, password: txtPassword))
        }
    }
    
    //MARK: User LoginRequest
    private func userLoginRequest(loginRequest: AuthRequest) {
        UserDefaultsManager.shared.authToken = nil
        showActivityIndicator = true
        authService.userLogin(LoginResponse.self, request: loginRequest)
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
                UserDefaultsManager.shared.authToken = response.data?.accessToken
                UserDefaultsManager.shared.authRefreshTokenKey = response.data?.refreshToken
               
                if (response.data?.verified) ?? false  {
                    weakSelf.getUserProfile()
                }else{
                    weakSelf.coordinator?.loadCompleteProfileView()
                }
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
    
    //MARK: User signUPRequest
    private func userSignupRequest(loginRequest: AuthRequest) {
        showActivityIndicator = true
        authService.userSignup(SignupResponse.self, request: loginRequest)
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
                if response.msg == StringConstants.signupSuccessfully{
                    weakSelf.changeConfigationSignUpView()
                    weakSelf.validationText = response.msg ?? ""
                    weakSelf.toastType = .success
                    //let model = AuthRequest(email: weakSelf.txtEmail, password: weakSelf.txtPassword)
                   // weakSelf.userLoginRequest(loginRequest: model)
                }else{
                   
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
