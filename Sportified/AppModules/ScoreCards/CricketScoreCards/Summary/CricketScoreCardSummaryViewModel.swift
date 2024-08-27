//
//  CricketScoreCardSummaryViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/08/2024.
//

import Foundation
class CricketScoreCardSummaryViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    var nearbyMatchesitem: NearbyMatchesList?
    @Published var cricketScoreCardSummary: CricketScoreCardSummary?
    
    @Published var  noOfOvers: String = ""
    @Published var  oversPerBowler: String = ""
    
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
