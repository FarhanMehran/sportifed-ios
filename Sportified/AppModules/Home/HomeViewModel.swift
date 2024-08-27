//
//  HomeViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published var nearbyMatchesList:[NearbyMatchesList] = []
    @Published var limet:Int = 20
    var isFirst = true
    init(coordinator: HomeCoordinator? = nil) {
        super.init()
        self.coordinator = coordinator
        self.getSportsNearby(limit: limet)
       
        
    }
    
    func pagination(){
        limet = limet+20
        print(limet)
        getSportsNearby(limit: limet)
    }
    
    func updateDataWhileUpdateMatch(item: NearbyMatchesList){
        
        if let index = nearbyMatchesList.firstIndex(where: { $0.id == item.id }) {
            nearbyMatchesList[index] = item
        }
        
        if let index = BaseData.shared.matchesList.firstIndex(where: { $0.id == item.id }) {
            BaseData.shared.matchesList[index] = item
            BaseData.shared.temmatchesList[index] = item
        }
    }
    
    func getSportsNearby(limit:Int) {
        print(limit)
        let request = SportFilterRequest(limit: limit, lat: 0.6789,long: 25.222, offset: 0)
        
        sportsServices.getSportsNearby(GetNearbyMatchesResponce.self, request: request)
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
                weakSelf.nearbyMatchesList = response.results ?? []
                weakSelf.showActivityIndicator = false
                if weakSelf.isFirst{
                    weakSelf.getPreference()
                    weakSelf.isFirst = false
                }
            }
            .store(in: &cancellableSet)
    }
    
    func getPreference() {
      // showActivityIndicator = true
       authService.getPreference(GetPreferenceResponce.self)
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
               BaseData.shared.favoriteSportsList = response.data?.sports
               weakSelf.showActivityIndicator = false
           }
           .store(in: &cancellableSet)
   }
   
}
