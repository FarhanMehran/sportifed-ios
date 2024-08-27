//
//  CompleteProfileViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import Foundation

class CompleteProfileViewModel: BaseViewModel {
    
    var coordinator: AuthCoordinator?
    @Published  var showDropDown = false
    @Published  var accountType = StringConstants.organizer
    @Published  var userName:String = ""
    @Published  var userPhoneNumber = ""
    @Published  var fullsUerPhoneNumber = ""
    @Published  var selectedCountryCode = ""
    @Published  var showCountryCodePicker: Bool = false
    @Published  var favoriteSportsList:[SportsData]?
    @Published  var favoriteSportsID:[Int]? = []
    @Published  var mobileCountryRegion: [RegionCountryCode] = Utility.getRegionCountryCode()
    
    
    func btnContinue(){
        if userName.isEmpty{
            toastType = .warning
            validationText = StringConstants.enterUserName
            return
        }
        else if userPhoneNumber.isEmpty || userPhoneNumber.count <= 8{
            toastType = .warning
            validationText = StringConstants.enterValidePhoneNumber
            return
        }
        fullsUerPhoneNumber = "\(selectedCountryCode)\(userPhoneNumber.replacingOccurrences(of: " ", with: ""))"
        let requestModel = CompleteProfileRequest(fullName: userName,
                                                  favSports: favoriteSportsID ?? [],
                                                  accountType: accountType,
                                                  phoneNumber: fullsUerPhoneNumber)
        completeProfileRequest(completeProfileRequest: requestModel)
    }
    
    //MARK: User CompleteProfileRequest
    private func completeProfileRequest(completeProfileRequest: CompleteProfileRequest) {
        showActivityIndicator = true
        authService.completeProfileRequest(LoginResponse.self, request: completeProfileRequest)
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
                let mobileNumber = "\(weakSelf.selectedCountryCode) \(weakSelf.userPhoneNumber.prefix(3)) ********"
                weakSelf.coordinator?.loadOTPView(userPhoneNumber: mobileNumber, dummyOTP: response.msg ?? "",routType: .completeProfile)
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
    
     func getSports() {
        showActivityIndicator = true
        authService.getSports(GetSportsResponce.self)
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
                weakSelf.favoriteSportsList = response.data
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
}
