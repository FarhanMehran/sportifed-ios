//
//  OutViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/08/2024.
//

import Foundation

class OutViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    var getResponse:((CricketScorecardResponce,User,Bool)->Void) = {_,_,_ in }
    var nearbyMatchesitem: NearbyMatchesList?
    
    @Published var  batting_team_id = 0
    @Published var  bowling_team_id = 0
    
    @Published var  striker: User?
    @Published var  nonStriker: User?
    @Published var  bowler: User?
    @Published var  keeper: User?
    
    @Published var  filder: User?
    
    @Published var  runs: String = ""
    @Published var  extraBalltype: String? = nil
    @Published var  wicketType: String = "run_out"
    
    @Published var  outPlayerID: Int? = nil
    @Published var  showBowlingPlayerList: Bool = false
    @Published var  playerList: [User] = []
   
    
    func viewWillAppear(){
        playerList = playerList.map { user in
            var updatedUser = user
            updatedUser.isSelected = false
            return updatedUser
        }
    }
    
    
    func btnClick(){
        if let outPlayerID = outPlayerID{
            let  out_id = outPlayerID == 0 ? striker?.id : nonStriker?.id
            if let filderID = filder?.id{
                let model = UpdateCricketScorecardRequest(match_id: nearbyMatchesitem?.id,
                                                          action: "ball",
                                                          player_id: striker?.id,
                                                          off_strike_id: nonStriker?.id,
                                                          team_id: batting_team_id,
                                                          extra_type: extraBalltype,
                                                          wicket: wicketType,
                                                          runs: Int(runs),
                                                          bowler_id: bowler?.id,
                                                          fielder: filderID,
                                                          out_id: out_id)
                updateCricketScorecard(model: model)
            }
        }
    }
    
    func checkOutType(){
        coordinator?.loadOutTypeView(outTypeCallBack: { wicketType in
            self.wicketType = wicketType
        })
    }
    
    func updateCricketScorecard(model: UpdateCricketScorecardRequest) {
        showActivityIndicator = true
        circketServices.updateCricketScorecard(CricketScorecardResponce.self ,requset: model)
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
                let user = weakSelf.outPlayerID == 0 ? weakSelf.striker : weakSelf.nonStriker
                let check = weakSelf.outPlayerID == 0 ? true : false
                weakSelf.getResponse(response,user!,check)
                weakSelf.coordinator?.popNavigationView()
            }
            .store(in: &cancellableSet)
    }
    
    func test(){
        // Create dummy striker and non-striker
        let dummyStriker = Striker(id: 1, name: "John Doe", runs: 45, balls: 30)
        let dummyNonStriker = Striker(id: 2, name: "Jane Smith", runs: 35, balls: 25)

        // Create dummy bowler
        let dummyBowler = Bowler(id: 1, name: "James Anderson", overs: "4.2", runsConceded: 25, wickets: 2)

        // Create dummy balls for current over details
        let dummyBalls = [
            Ball(id: 1, runs: 1, wide: false, noBall: false, legBye: false, bye: false),
            Ball(id: 2, runs: 0, wide: false, noBall: false, legBye: false, bye: false),
            Ball(id: 3, runs: 4, wide: false, noBall: false, legBye: false, bye: false),
            Ball(id: 4, runs: 2, wide: true, noBall: false, legBye: false, bye: false),
            Ball(id: 5, runs: 0, wide: false, noBall: true, legBye: false, bye: false),
            Ball(id: 6, runs: 6, wide: false, noBall: false, legBye: false, bye: false)
        ]

        // Create dummy current over details
        let dummyCurrentOverDetails = CurrentOverDetails(balls: dummyBalls, runsConceded: 13)

        // Create dummy current partnership
        let dummyCurrentPartnership = CurrentPartnership(runs: 80, balls: 55)

        // Create dummy cricket scorecard
        let dummyCricketScorecard = CricketScorecard(
            currentOver: 35,
            currentBall: 2,
            team1Score: 150,
            team2Score: 145,
            team1Wickets: 3,
            team2Wickets: 4,
            striker: dummyStriker,
            nonStriker: dummyNonStriker,
            currentPartnership: dummyCurrentPartnership,
            bowler: dummyBowler,
            currentOverDetails: dummyCurrentOverDetails
        )

        // Create dummy cricket scorecard response
        let cricketScorecard = CricketScorecardResponce(
            msg: "Success",
            data: dummyCricketScorecard
        )
        let user = outPlayerID == 0 ? striker : nonStriker
        let check = outPlayerID == 0 ? true : false
        getResponse(cricketScorecard,user!,check)
        coordinator?.popNavigationView()
    
    }
}
