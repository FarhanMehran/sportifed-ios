//
//  TossViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 30/07/2024.
//

import Foundation
class TossViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published var nearbyMatchesitem: NearbyMatchesList?
    
    @Published var  tosswinnerid: Int? = nil
    @Published var  tossdecision: Int? = nil
    @Published var  noOfOvers: String? = ""
    @Published var  oversPerBowler: String? = ""
    
    @Published var  batting_team_id = 0
    @Published var  bowling_team_id = 0
    
    
    func btnStartMatchClick(){
        if tosswinnerid == nil{
            validationText = "Who won the toss?"
            return
        }else if tosswinnerid == nil {
            validationText = "Winner of the toss elected to?"
            return
        }
        if let tosswinnerid = tosswinnerid{
            let model = UpdateStatusCricketRequest(toss_winner_id: nearbyMatchesitem?.teams?[tosswinnerid].id,
                                                   toss_decision: tossdecision == 1 ? "bat" : "bowl",
                                                   match_id: nearbyMatchesitem?.id,
                                                   total_overs: Int(noOfOvers ?? "0"),
                                                   match_started: true)
            updateStatusCricket(model: model)
        }
    }
    
    
    func updateStatusCricket(model: UpdateStatusCricketRequest) {
        showActivityIndicator = true
        circketServices.updateStatusCricket(BaseResponce.self ,requset: model)
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
                weakSelf.loadView()
                weakSelf.showActivityIndicator = false
            }
            .store(in: &cancellableSet)
    }
    
    func loadView(){
        
        if let tosswinnerid = tosswinnerid{
            
            if tosswinnerid == 0 {
                // Team A won the toss
                if tossdecision == 0 {
                    // Team A decides to bat
                    batting_team_id = nearbyMatchesitem?.teams?[0].id ?? 0
                    bowling_team_id = nearbyMatchesitem?.teams?[1].id ?? 0
                    
                } else {
                    // Team A decides to bowl
                    batting_team_id = nearbyMatchesitem?.teams?[1].id ?? 0
                    bowling_team_id = nearbyMatchesitem?.teams?[0].id ?? 0
                }
                
            } else if tosswinnerid == 1 {
                // Team B won the toss
                if tossdecision == 0 {
                    // Team B decides to bat
                    batting_team_id = nearbyMatchesitem?.teams?[1].id ?? 0
                    bowling_team_id = nearbyMatchesitem?.teams?[0].id ?? 0
                    
                    
                } else {
                    // Team B decides to bowl
                    batting_team_id = nearbyMatchesitem?.teams?[0].id ?? 0
                    bowling_team_id = nearbyMatchesitem?.teams?[1].id ?? 0
                    
                }
            }
            coordinator?.loadStartInningsView(nearbyMatchesitem: nearbyMatchesitem!,
                                              tosswinnerid: tosswinnerid,
                                              tossdecision: tossdecision ?? 0,
                                              noOfOvers: noOfOvers ?? "",
                                              batting_team_id: batting_team_id,
                                              bowling_team_id: bowling_team_id,oversPerBowler:oversPerBowler ?? "")
        }
        
        
    }
    
    func test(){
        loadView()
    }
    
}
