//
//  CreatTournamentViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 14/06/2024.
//

import Foundation

class CreatTournamentViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published var name:String = ""
    @Published var description:String = ""
    @Published var sport:SportsData?
    @Published var showDropDown = false
    @Published  var favoriteSportsList:[SportsData]?
    
    func btnCreatToutnament(){
        if name.isEmpty || description.isEmpty{
            validationText = "Fill the all fields"
            toastType = .warning
            return
        }
        let request = PostTournamentRequest(title: name,
                                            description: description,
                                            venue: "block ground",
                                            sport: sport?.id,
                                            gameAccess: "public",
                                            skillRequired: "beginner",
                                            playersLimit: "10",
                                            byoe: true,
                                            fee: "20")
        postTournament(request: request)
    }
    
    func getSports() {
       // showActivityIndicator = true
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
                weakSelf.sport = weakSelf.favoriteSportsList?[0] ?? SportsData()
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
    
    private func postTournament(request: PostTournamentRequest){
         showActivityIndicator = true
         sportsServices.postTournament(PostTournamentResponce.self, request: request)
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
             weakSelf.coordinator?.popNavigationView()
         }
         .store(in: &cancellableSet)
     }

}
