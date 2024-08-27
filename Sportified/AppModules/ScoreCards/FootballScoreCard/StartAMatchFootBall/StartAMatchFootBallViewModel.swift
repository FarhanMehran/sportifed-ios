//
//  StartAMatchFootBallViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/08/2024.
//

import Foundation
enum FootBallMatchTime:Int{
    case time_20 = 20
    case time_30 = 30
    case time_60 = 60
    case time_90 = 90
    case customTime
}
class StartAMatchFootBallViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    @Published var nearbyMatchesitem: NearbyMatchesList?
    
    @Published var  selectedMatchTime: FootBallMatchTime = .time_20
    
    @Published var  txtcustomTime: String = ""
    
    @Published var  showCustomTimePopUp: Bool = false
    
    
    @Published var  btnExtraTime: Bool = false
    @Published var  penalty_shootout: Bool = false
    
    
    func getTeamName(team: Int) -> String? {
        return nearbyMatchesitem?.teams?[team].name
    }
    
    func testClick(){
        coordinator?.loadFootballScoreCardView(model: nearbyMatchesitem!, matchTime: getTime(selectedMatchTime))
    }
    
    func btnStartMatch(){
        if selectedMatchTime == .customTime && txtcustomTime.isEmpty{
            validationText = "Selecte the custom Time"
            return
        }
        let mode = FootBallRequest(started:true,
                                   match_id: nearbyMatchesitem?.id,
                                   extra_time: btnExtraTime,
                                   penalty_shootout: penalty_shootout,
                                   first_half: true,
                                   second_half: true,
                                   total_time: getTime(selectedMatchTime))
        updateCricketScorecard(model: mode)
    }
    
    func updateCricketScorecard(model: FootBallRequest) {
        showActivityIndicator = true
        circketServices.updateStatusFootBall(CricketScorecardResponce.self ,requset: model)
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
                if response.msg == "Status updated successfully."{
                    weakSelf.coordinator?.loadFootballScoreCardView(model: weakSelf.nearbyMatchesitem!, matchTime: weakSelf.getTime(weakSelf.selectedMatchTime))
                }
            }
            .store(in: &cancellableSet)
    }
    
    func getTime(_ matchTime: FootBallMatchTime) -> Int {
        switch matchTime {
        case .customTime:
            return (Int(txtcustomTime) ?? 0) * 60
        case .time_20:
            return 20 * 60
        case .time_30:
            return 30 * 60
        case .time_60:
            return 60 * 60
        case .time_90:
            return 90 * 60
        }
    }
    
    func test(){
        let team1Users = [
            User(id: 1, fullName: "Karachi1", img: nil),
            User(id: 2, fullName: "Karachi2", img: nil),
            User(id: 3, fullName: "Karachi3", img: nil),
            User(id: 4, fullName: "Karachi4", img: nil)
        ]

        let team2Users = [
            User(id: 5, fullName: "Lahore1", img: nil),
            User(id: 6, fullName: "Lahore2", img: nil),
            User(id: 7, fullName: "Lahore3", img: nil),
            User(id: 8, fullName: "Lahore4", img: nil)
        ]
        
        let team1 = Team(
            id: 1,
            name: "Karachi",
            createdAt: "2024-08-01T12:00:00Z",
            updatedAt: "2024-08-01T12:00:00Z",
            match: 1,
            img: "/media/banner/ball.png",
            users: team1Users
        )

        let team2 = Team(
            id: 2,
            name: "Lahore",
            createdAt: "2024-08-01T12:00:00Z",
            updatedAt: "2024-08-01T12:00:00Z",
            match: 1,
            img: "/media/banner/lahore.png",
            users: team2Users
        )
        // Create dummy NearbyMatchesList
        let dummyNearbyMatch = NearbyMatchesList(
            id: 1,
            title: "Cricket Match",
            description: "A friendly cricket match between Karachi and Lahore.",
            venue: "National Stadium",
            venueLat: "24.8607",
            venueLong: "67.0011",
            gameDateTime: "2024-08-15T18:00:00Z",
            gameAccess: .gameAccessPublic,
            gameType: .regular,
            skillRequired: .intermediate,
            playersLimit: 20,
            byoe: true,
            fee: "100",
            joinCode: "JOIN123",
            createdAt: "2024-08-01T12:00:00Z",
            updatedAt: "2024-08-01T12:00:00Z",
            sport: 1,
            tournament: 1,
            createdBy: 1,
            users: team1Users + team2Users, // Combined users for simplicity
            teams: [team1, team2]
        )
        nearbyMatchesitem = dummyNearbyMatch
    }
}
