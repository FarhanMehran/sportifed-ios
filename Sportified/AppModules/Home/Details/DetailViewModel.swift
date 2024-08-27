//
//  DetailViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import Foundation

class DetailViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    var routType: DetailViewRoutType = .home
    var callBack:((NearbyMatchesList)->Void) = {_ in}
    @Published var nearbyMatchesitem: NearbyMatchesList?
    @Published var cricketScoreCardSummary: CricketScoreCardSummary?
    
    @Published var title: String = ""
    @Published var showingAlert: Bool = false
    @Published var teamA: Bool = false{
        didSet{
            if teamA{
                teamB = false
            }
        }
    }
    @Published var teamB: Bool = false{
        didSet{
            if teamB{
                teamA = false
            }
        }
    }
    @Published var otpCode: [String] =  Array(repeating: "", count: 4)
    @Published var joinCode = ""{
        didSet {
            guard joinCode.count <= 4,
                  joinCode.last?.isNumber ?? true else {
                joinCode = oldValue
                return
            }
        }
    }
    
    func getOTPCode(index: Int) -> String {
        guard joinCode.count >= (index + 1) else {
            return otpCode[index]
        }
        return String(Array(joinCode)[index])
    }
    
    func btnJoinMatch(){
        if joinCode.count < 4 && nearbyMatchesitem?.gameAccess == GameAccess.invite{
            validationText = "Enter join code"
            toastType = .warning
            return
        }
        if !teamA && !teamB{
            validationText = "Select the Team"
            toastType = .warning
            return
        }
        showingAlert.toggle()
        joinMatchInvitOnly(request: joinPublicMatchRequest(match_id: nearbyMatchesitem?.id,
                                                           join_code: joinCode,
                                                           team: teamA ? nearbyMatchesitem?.teams?.first?.name ?? "Team A" : nearbyMatchesitem?.teams?.last?.name ?? "Team B"))
    }
    
    func joinMatchInvitOnly(request:joinPublicMatchRequest) {
        showActivityIndicator = true
        sportsServices.joinPublicMatch(BaseResponce.self, request: request)
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
                let user = UserDefaultsManager.shared.userProfileData
                let data = User(id: user?.id ?? 0,fullName: user?.fullName ?? "",img:user?.img ?? "")
                if weakSelf.teamA{
                    weakSelf.nearbyMatchesitem?.teams?[0].users?.insert(data, at: 0)
                }else{
                    weakSelf.nearbyMatchesitem?.teams?[1].users?.insert(data, at: 0)
                }
                weakSelf.nearbyMatchesitem?.users?.insert(data, at: 0)
                weakSelf.callBack(weakSelf.nearbyMatchesitem!)
                weakSelf.coordinator?.popNavigationView()
                weakSelf.showActivityIndicator = false
               
            }
            .store(in: &cancellableSet)
    }
    
    
    func getcricketScoreCardSummary() {
        showActivityIndicator = true
        
        let req = SportFilterRequest(match_id: nearbyMatchesitem?.id ?? 0)
        circketServices.getCricketScorecard(CricketScoreCardSummary.self ,requset: req)
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
                
                weakSelf.showActivityIndicator = false
                weakSelf.cricketScoreCardSummary = response
                
            }
            .store(in: &cancellableSet)
    }
}
