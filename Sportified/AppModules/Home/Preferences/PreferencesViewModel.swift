//
//  PreferencesViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import Foundation
class PreferencesViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published  var itemIndex: Int?
    @Published  var favoriteSportsList:[Sport]?
    func btnSaveChanges(sportsItem: Sport){
        print(sportsItem)
        changePreference(sport_id: sportsItem.id ?? 0, action: sportsItem.userFav ?? false)
    }
    

    
    func changePreference(sport_id: Int, action: Bool) {
        authService.changePreference(GetPreferenceResponce.self, request: ChangePreferenceRequest(sport_id: sport_id, action: action))
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
                weakSelf.toastType = .success
                weakSelf.showActivityIndicator = false
                BaseData.shared.favoriteSportsList = weakSelf.favoriteSportsList
                NotificationCenter.default.post(name: .selectedTab, object: nil)
                NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: ["data": "Hello, SwiftUI!"])
            }
            .store(in: &cancellableSet)
    }
}
