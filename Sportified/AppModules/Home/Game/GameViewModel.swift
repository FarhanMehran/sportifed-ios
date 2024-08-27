//
//  GameViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import Foundation
class GameViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    
    @Published var sort = false{
        didSet{
            if sort{
                BaseData.shared.temmatchesList.reverse()
            }else{
                BaseData.shared.temmatchesList = BaseData.shared.matchesList
            }
        }
    }
    
    init(coordinator: HomeCoordinator? = nil) {
        super.init()
        self.coordinator = coordinator
        self.getAllmatch()
    }

    
    func getAllmatch() {
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
