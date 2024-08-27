//
//  MatchesScoreViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import Foundation
class MatchesScoreViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    var routType: MatchesScoreRoutType = .matchesScore
    @Published var temmatchesList:[NearbyMatchesList] = []
    @Published var matchList:[NearbyMatchesList] = []
    @Published var sort = false{
        didSet{
            if sort{
                temmatchesList.reverse()
            }else{
                temmatchesList = matchList
            }
        }
    }
    
    @Published var title: String = ""
    
    func onAppear(){
        temmatchesList = BaseData.shared.temmatchesList
        temmatchesList = temmatchesList.filter({ $0.users?.contains(where: {$0.fullName == UserDefaultsManager.shared.userProfileData?.fullName ?? ""}) == true})
        matchList = temmatchesList
        if routType == .matchesScore{
            title = StringConstants.matchesScore
        }else if routType == .myGame{
            title = StringConstants.myGames
        }else{
            title = StringConstants.scoreCard
        }
    }
    
    func getSportsNearby() {
        showActivityIndicator = true
        sportsServices.getAllmatch(GetMatchesResponce.self)
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
                BaseData.shared.matchesList = response.data ?? []
                BaseData.shared.temmatchesList = response.data ?? []
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
}
