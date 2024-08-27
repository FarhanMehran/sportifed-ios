//
//  StartMatchBasketballScoreCardsViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 15/08/2024.
//

import Foundation
class StartMatchBasketballScoreCardsViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    @Published var nearbyMatchesitem: NearbyMatchesList?
    
    @Published var  selectTime: String = ""
    
    @Published var  txtcustomTime: String = ""
    @Published var  matchTime: Int = 0
    @Published var  showCustomTimePopUp: Bool = false
    @Published var  btnExtraTime: Bool = false

    
    
    func getTeamName(team: Int) -> String? {
        return nearbyMatchesitem?.teams?[team].name
    }
    
    
    func btnClickLeague(){
        if matchTime == 3 && selectTime == "" {
            validationText = "Selecte the custom Time"
            return
        }
        var time = 0
        if matchTime == 0{
            time = 48
        }else if matchTime == 1{
            time = 40
        }else if matchTime == 2{
            time = 40
        }else if matchTime == 3{
            time = Int(selectTime ?? "0") ?? 0
        }
        coordinator?.loadBasketballScoreMakeCardView(model: nearbyMatchesitem!, matchTime: time)
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
