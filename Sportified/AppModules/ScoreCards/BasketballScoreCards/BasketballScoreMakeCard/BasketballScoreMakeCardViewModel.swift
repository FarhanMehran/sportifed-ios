//
//  BasketballScoreMakeCardViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 18/08/2024.
//

import Combine
import Foundation

class BasketballScoreMakeCardViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    @Published var nearbyMatchesitem: NearbyMatchesList?
    
    
    @Published var  showFoulDropDown: Bool = false
    @Published var  isSelectedFoulTeam: Int? = nil
    
    @Published var  selectedMatchTime: Int = 30
    @Published var otpTimePatternLogin = "00 : 00"
    var otpTimer: AnyCancellable!
    
    @Published var  addPointsSelectTeam: Team = Team()
    @Published var  addPointsSelectPlayer: User = User()
    @Published var  addPontTxt: String? = nil
    @Published  var addPoint:[SelectedDate] = []
    
    
    @Published var  addTimeoutSelect: String? = nil
    @Published var  addTimeoutSelectTeam: Team = Team()
    @Published var  addTimeoutSelectPlayer: User = User()
    
    
    @Published  var foulTypeList:[SelectedDate] = []
    @Published var  foulType: String? = nil
    
    @Published  var outTimeList:[SelectedDate] = []
    
    @Published var  showAddPoint: Bool = false
    
   
    
    @Published var  foulSelectTeam: Team = Team()
    @Published var  foulSelectPlayer: User = User()

   
    
    @Published var  showDropDown: Bool = false
    @Published var  isStopTime: Bool = false
    
    
    @Published var footballScoreCardTime: FootballScoreCardTime = .firstHalf
    @Published var dropDownType: FootballScoreCardDropDownType = .goleSelectPlayer
    @Published var showDropdown: Bool = false
    @Published var selectedTime = 0
    
 
    

    @Published var  foulTime: String = ""
    
   
    
    @Published var  redSelectTeam: Team = Team()
    @Published var  redelectPlayer: User = User()
    
    @Published var  player_id: Int? = nil
    @Published var  team_id: Int = 0
    @Published var  goleTime: Int = 0
   // @Published var  goal_type: String? = nil
    @Published var  card_type: String? = nil
    
    @Published var  showSelectedTeam: Bool = false
    @Published  var teamList:[SelectedDate] = []
 
    
    @Published  var playerList:[User] = []
    
   
    
    @Published var  showFoulSelectedTeam: Bool = false
    @Published var  showFoulTypeSelectedTeam: Bool = false
    
    @Published var  showAddTimeoutSelectTeam: Bool = false
    @Published var  showAddTimeoutTypeSelectTeam: Bool = false
    
    @Published var  showRexSelectedTeam: Bool = false
    
    func viewWillAppear(){
         teamList = [SelectedDate(name: nearbyMatchesitem?.teams?.first?.name ?? "", isSelected: false),
                        SelectedDate(name: nearbyMatchesitem?.teams?.last?.name ?? "", isSelected: false)]
        
        addPoint = [SelectedDate(name:  "FTM (1 Point)", isSelected: false),
                    SelectedDate(name:  "2 Points", isSelected: false),
                    SelectedDate(name:  "3 Points", isSelected: false)]
        
        foulTypeList = [SelectedDate(name:  "Personal Foul", isSelected: false),
                    SelectedDate(name:  "Technical Foul", isSelected: false),
                    SelectedDate(name:  "Flagrant Foul", isSelected: false)]
        
        outTimeList = [SelectedDate(name:  "Team Timeout", isSelected: false),
                    SelectedDate(name:  "Official Timeout", isSelected: false),]
        
    }
    
    func getTeam(){
        var team = Team()
        if addPointsSelectTeam != Team(){
            team = addPointsSelectTeam
        }else if foulSelectTeam != Team(){
            team = foulSelectTeam
        }else if addTimeoutSelectTeam != Team(){
            team = addTimeoutSelectTeam
        }else{
            return
        }
        if team.id == nearbyMatchesitem?.teams?.first?.id{
            playerList = nearbyMatchesitem?.teams?.first?.users ?? []
        }else{
            playerList = nearbyMatchesitem?.teams?.last?.users ?? []
        }
    }
    
    func getTeamName(team: Int) -> String? {
       return nearbyMatchesitem?.teams?[team].name
    }
    
    @Published var  selectTeamForGole: Int = 1
    
    func getTeamForGole(team: Int) -> [User]{
        if team == 1{
            return nearbyMatchesitem?.teams?.first?.users ?? []
        }else{
            return nearbyMatchesitem?.teams?.last?.users ?? []
        }
    }
    
    func btnGole(){
        showFoulDropDown.toggle()
    }
    
    func updateCricketScorecard(model: FootBallRequest) {
       // showActivityIndicator = true
        circketServices.updateStatusFootBall(BaseResponce.self ,requset: model)
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
              //  weakSelf.showActivityIndicator = false
                weakSelf.validationText = response.msg ?? ""
            }
            .store(in: &cancellableSet)
    }
    func test(){
        let team1Users = [
            User(id: 1, fullName: "Karachi1", img: ""),
            User(id: 2, fullName: "Karachi2", img: "")
        ]

        let team2Users = [
            User(id: 5, fullName: "Lahore1", img: ""),
            User(id: 6, fullName: "Lahore2", img: "")
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
    
    func otpResendTimer() {
        
        otpTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.selectedMatchTime > 0{
                    if !self.isStopTime{
                        self.otpTimePatternLogin = Utility.secondsToMinutesSeconds(self.selectedMatchTime)
                        self.selectedMatchTime -= 1
                    }
                } else {
                    self.otpTimePatternLogin = "00 : 00"
                    self.selectedMatchTime = 30
                    
                }
            }
    }
}
