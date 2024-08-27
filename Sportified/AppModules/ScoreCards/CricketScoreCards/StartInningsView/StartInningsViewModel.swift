//
//  StartInningsViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 30/07/2024.
//

import Foundation
enum StartInningsViewEnum {
    case startInning
    case changeInning
}
struct ChangeInningModel{
    var  nearbyMatchesitem: NearbyMatchesList?
    var  striker: User?
    var  nonStriker: User?
    var  bowler: User?
    var  keeper: User?
    var  matchPlayingTeam: String?
}
class StartInningsViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published var nearbyMatchesitem: NearbyMatchesList?
    var routType:StartInningsViewEnum =  .startInning
    @Published var  tosswinnerid: Int? = nil
    @Published var  tossdecision: Int? = nil
    @Published var  noOfOvers: String = ""
    @Published var  oversPerBowler: String = ""
    
    @Published var  striker: User?
    @Published var  nonStriker: User?
    @Published var  bowler: User?
    @Published var  keeper: User?
    
    
    @Published var  matchPlayingTeam: String = ""
    
    @Published var  batting_team_id = 0
    @Published var  bowling_team_id = 0
    
    @Published var  battingTeamPlayers:[User] = []
    @Published var  bowlingTeamPlayers:[User] = []
    
    @Published var  showBatingPlayerList = 0
    @Published var  showBowlingPlayerList = 0
    
    var changeInning:((ChangeInningModel)->Void) = {_  in }
  
    
    func validation(){
       
       
        
        
    }
    
    func btnClick(){
        if routType == .startInning{
            if (striker != nil), (nonStriker != nil),(bowler != nil),keeper != nil{
                
            }else{
                validationText = "Select remaining Player"
                return
            }
            let model = UpdateStatusCricketRequest(toss_winner_id: nearbyMatchesitem?.teams?[tosswinnerid ?? 0].id,
                                                   toss_decision: tossdecision == 0 ? "bat" : "bowl",
                                                   match_id: nearbyMatchesitem?.id,
                                                   bowling_team_id: bowling_team_id,
                                                   batting_team_id: batting_team_id)
            updateStatusCricket(model: model)
        }else{
            /// chanage Inning
            if (striker != nil), (nonStriker != nil),(bowler != nil),keeper != nil{
                
            }else{
                validationText = "Select remaining Player"
                return
            }
            if let index = nearbyMatchesitem?.teams?.firstIndex(where: { $0.id == batting_team_id}) {
                matchPlayingTeam = nearbyMatchesitem?.teams?[index].name ?? ""
            }
            changeInning(ChangeInningModel(nearbyMatchesitem: nearbyMatchesitem, striker: striker, nonStriker: nonStriker, bowler: bowler, keeper: keeper, matchPlayingTeam: matchPlayingTeam))
            coordinator?.popNavigationView()
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
                weakSelf.showActivityIndicator = false
                weakSelf.startInning()
            }
            .store(in: &cancellableSet)
    }
    
    func startInning(){
        if routType == .startInning{
            matchPlayingTeam = nearbyMatchesitem?.teams?[tosswinnerid ?? 0].name ?? ""
            coordinator?.loadCricketScoreCardsView(nearbyMatchesitem: nearbyMatchesitem!,
                                                   tosswinnerid:  tosswinnerid ?? 0,
                                                   tossdecision:  tossdecision ?? 0,
                                                   noOfOvers:  noOfOvers,
                                                   oversPerBowler:  oversPerBowler,
                                                   striker:  striker!,
                                                   nonStriker:  nonStriker!,
                                                   bowler:  bowler!,
                                                   keeper:  keeper!,
                                                   matchPlayingTeam:  matchPlayingTeam,
                                                   batting_team_id:  batting_team_id,
                                                   bowling_team_id:  bowling_team_id,
                                                   battingTeamPlayers: battingTeamPlayers,
                                                   bowlingTeamPlayers: bowlingTeamPlayers)
        }else{
            //test
//            if let index = nearbyMatchesitem?.teams?.firstIndex(where: { $0.id == batting_team_id}) {
//                matchPlayingTeam = nearbyMatchesitem?.teams?[index].name ?? ""
//            }
//            changeInning(ChangeInningModel(nearbyMatchesitem: nearbyMatchesitem, striker: striker, nonStriker: nonStriker, bowler: bowler, keeper: keeper, matchPlayingTeam: matchPlayingTeam))
//            coordinator?.popNavigationView()
        }
    }
    
    func getTeamsPlayer() {
        guard let teams = nearbyMatchesitem?.teams,
              teams.count >= 2 else {
            print("Insufficient team data")
            return
        }
        
        let battingTeamID = batting_team_id
        let bowlingTeamID = bowling_team_id
        let firstTeam = teams.first
        let lastTeam = teams.last
        if firstTeam?.id == battingTeamID && lastTeam?.id == bowlingTeamID {
            self.battingTeamPlayers = firstTeam?.users ?? []
            self.bowlingTeamPlayers = lastTeam?.users ?? []
        } else if lastTeam?.id == battingTeamID && firstTeam?.id == bowlingTeamID {
            self.battingTeamPlayers = lastTeam?.users ?? []
            self.bowlingTeamPlayers = firstTeam?.users ?? []
        } else {
            print("Team IDs do not match expected values.")
        }
    }
    
    func changeInningTeamSwap(){
        let tempID = bowling_team_id
        bowling_team_id = batting_team_id
        batting_team_id = tempID
        
        let temTeam = battingTeamPlayers
        battingTeamPlayers = bowlingTeamPlayers
        bowlingTeamPlayers = temTeam
        
        
        
        battingTeamPlayers = battingTeamPlayers.map { user in
            var updatedUser = user
            updatedUser.isSelected = false
            return updatedUser
        }
        bowlingTeamPlayers = bowlingTeamPlayers.map { user in
            var updatedUser = user
            updatedUser.isSelected = false
            return updatedUser
        }
    }
    
    func test(){
        if routType == .startInning{
            matchPlayingTeam = nearbyMatchesitem?.teams?[tosswinnerid ?? 0].name ?? ""
            coordinator?.loadCricketScoreCardsView(nearbyMatchesitem: nearbyMatchesitem!,
                                                   tosswinnerid:  tosswinnerid ?? 0,
                                                   tossdecision:  tossdecision ?? 0,
                                                   noOfOvers:  noOfOvers,
                                                   oversPerBowler:  oversPerBowler,
                                                   striker:  striker!,
                                                   nonStriker:  nonStriker!,
                                                   bowler:  bowler!,
                                                   keeper:  keeper!,
                                                   matchPlayingTeam:  matchPlayingTeam,
                                                   batting_team_id:  batting_team_id,
                                                   bowling_team_id:  bowling_team_id,
                                                   battingTeamPlayers: battingTeamPlayers,
                                                   bowlingTeamPlayers: bowlingTeamPlayers)
        }else{
            //test
            if let index = nearbyMatchesitem?.teams?.firstIndex(where: { $0.id == batting_team_id}) {
                matchPlayingTeam = nearbyMatchesitem?.teams?[index].name ?? ""
            }
            changeInning(ChangeInningModel(nearbyMatchesitem: nearbyMatchesitem, striker: striker, nonStriker: nonStriker, bowler: bowler, keeper: keeper, matchPlayingTeam: matchPlayingTeam))
            coordinator?.popNavigationView()
        }
    }
}
