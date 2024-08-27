//
//  ProfileViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 06/05/2024.
//

import Foundation
import UIKit
class ProfileViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published var showPassword = false
    @Published var fullName = UserDefaultsManager.shared.userProfileData?.fullName ?? ""
    @Published var email = UserDefaultsManager.shared.userProfileData?.email ?? ""
    @Published var password = ""
    @Published var selectedImage: UIImage?
    
    func btnSaveChanges(){
        if fullName.isEmpty {
            validationText = "Enter your name"
            toastType = .warning
            return
        }
        if password.count < 8 {
            validationText = "Password must be at least 8 characters"
            toastType = .warning
            return
        }
        changeProfile()
    }
    
    func changeProfile(){
        showActivityIndicator = true
        UserService.shared.editUserImage(imageData:  selectedImage!.jpegData(compressionQuality: 0.2)!,
                                         parameters: ["full_name": fullName,
                                                      "password": password,
                                                      "phone": UserDefaultsManager.shared.userProfileData?.phoneNo ?? ""
                                                     ], completion: {
            (result: Result<SignupResponse, Error>) in
            switch result {
            case .failure(let error):
                self.validationText = error.localizedDescription
                self.showActivityIndicator = false
                
            case .success(let response):
                print("Login Response \(response)")
                self.validationText = response.msg ?? ""
                self.toastType = .success
                self.showActivityIndicator = false
                self.getUserProfile()
            }
        })
        
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
                weakSelf.showActivityIndicator = false
                weakSelf.coordinator?.popNavigationView()
            }
            .store(in: &cancellableSet)
    }
}
