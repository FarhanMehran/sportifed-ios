//
//  StartMatchSquashScoreCardsViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 19/08/2024.
//

import Foundation
class StartMatchSquashScoreCardsViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published var nearbyMatchesitem: NearbyMatchesList?
    
    @Published var isShowHandicap: Bool = false
    
    @Published var matchFormat: String? = nil
    @Published var isShowmatchFormat: Bool = false
    @Published  var matchFormatList:[SelectedDate] = [SelectedDate(name: "Singles", isSelected: false),
                                                      SelectedDate(name: "Doubles", isSelected: false)]
   
    @Published var matchType : String? = nil
    @Published var isShowMatchType : Bool = false
    @Published  var matchTypeList:[SelectedDate] = [SelectedDate(name: "Best of 3 games", isSelected: false),
                                                      SelectedDate(name: "Best of 5 games ", isSelected: false)]
    
    @Published var pointstoWin : String? = nil
    @Published var isShowPointstowin : Bool = false
    @Published var pointstowinList:[SelectedDate] = [SelectedDate(name: "11 Points (Standard PAR)", isSelected: false),
                                                      SelectedDate(name: "9 Points (Traditional HIHO)", isSelected: false)]
    
    @Published var courtNumber : String? = nil
    @Published var isShowCourtNumber : Bool = false
    @Published var courtNumberList:[SelectedDate] = [SelectedDate(name: "1", isSelected: false),
                                                      SelectedDate(name: "2", isSelected: false),
                                                      SelectedDate(name: "3", isSelected: false),
                                                      SelectedDate(name: "4", isSelected: false),
                                                      SelectedDate(name: "5", isSelected: false),
                                                      SelectedDate(name: "6", isSelected: false),
                                                      SelectedDate(name: "7", isSelected: false),
                                                      SelectedDate(name: "8", isSelected: false),
                                                      SelectedDate(name: "9", isSelected: false),
                                                      SelectedDate(name: "10", isSelected: false),]
    
    func btnClick(){
    
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
