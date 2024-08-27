//
//  SquashScoreCardsSummaryViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 19/08/2024.
//

import Foundation
class SquashScoreCardsSummaryViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    var nearbyMatchesitem: NearbyMatchesList?
    @Published var modelData:FootballScoreCardSummaryModel?
    @Published var goleLsit:[Card] = []
    @Published var team1:String = ""
    @Published var team2:String = ""
    
  
    
    func footballScoreCardSummary() {
        let req = SportFilterRequest(match_id: nearbyMatchesitem?.id ?? 33)
        showActivityIndicator = true
        circketServices.getFootballScore(FootballScoreCardSummaryModel.self, requset: req)
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
                weakSelf.validationText = response.msg ?? ""
                weakSelf.modelData = response
                weakSelf.team1 = response.data?.team1 ?? "Team A"
                weakSelf.team2 = response.data?.team2 ?? "Team A"
                weakSelf.setGoleList()
               
            }
            .store(in: &cancellableSet)
    }
    
    func setGoleList(){
        goleLsit = (modelData?.data?.goals ?? []) + (modelData?.data?.cards ?? [])
        goleLsit.sort { (item1, item2) -> Bool in
            let time1 = parseTime(item1.time)
            let time2 = parseTime(item2.time)
            return time1 < time2
        }
    }
    
    func test(){
       //  Creating dummy goals data
        let goal1 = Card(playerID: 1, playerFullName: "Player 1", teamID: 1, teamName: "Team 1", time: "12'", cardType: nil, goalType: "normal")
        let goal2 = Card(playerID: 2, playerFullName: "Player 2", teamID: 1, teamName: "Team 1", time: "24'", cardType: nil, goalType: "pa")
        let goal3 = Card(playerID: 1, playerFullName: "Player 1", teamID: 2, teamName: "Team 2", time: "38'", cardType: nil, goalType: "Pa")

        // Creating dummy cards data
     //   let card1 = Card(playerID: 1, playerFullName: "Player 1", teamID: 1, teamName: "Team 1", time: "45'", cardType: "Red", goalType: nil)
        let card2 = Card(playerID: 2, playerFullName: "Player 2", teamID: 2, teamName: "Team 2", time: "25'", cardType: "Yellow", goalType: nil)
     //   let card3 = Card(playerID: 1, playerFullName: "Player 2", teamID: 1, teamName: "Team 2", time: "67'", cardType: "Yellow", goalType: nil)

        // Creating the summary data
        let scoreCardData = FootballScoreCardSummaryData(
            matchID: 12345,
            team1: "Team 1",
            team2: "Team 2",
            team1Score: 2,
            team2Score: 1,
            extraTime: false,
            penaltyShootout: false,
            firstHalf: true,
            secondHalf: true,
            goals: [goal1, goal2, goal3],
            cards: [card2],
            matchStarted: true,
            matchTime: 90,
            matchCompleted: true
        )
        team1 = scoreCardData.team1 ?? "Team A"
        team2 = scoreCardData.team2 ?? "Team A"
       //  Creating the final summary model
        let scoreCardSummary = FootballScoreCardSummaryModel(msg: "Match summary", data: scoreCardData)
        modelData = scoreCardSummary
        goleLsit = (modelData?.data?.goals ?? []) + (modelData?.data?.cards ?? [])
         
       //   Optional: Sort the combined list by time
        goleLsit.sort { (item1, item2) -> Bool in
            let time1 = parseTime(item1.time)
            let time2 = parseTime(item2.time)
            return time1 < time2
        }
        //  Checking the count of the merged list
         print(goleLsit.count)
    }
    
}
