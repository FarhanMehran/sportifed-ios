//
//  CircketScoreCardViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 26/07/2024.
//

import Foundation

class CricketScoreCardsViewModel: BaseViewModel {
   
    
    
    var coordinator: HomeCoordinator?
    
    @Published  var nearbyMatchesitem: NearbyMatchesList?
    @Published var cricketScorecard: CricketScorecard?
    
    @Published var  runsList: [Ball] = []
    var response:CricketScorecardResponce? {
        didSet{
            if let res = response{
                
                self.outPlayer(response: res)
                self.tempBattingTeamPlayers.removeAll { player in
                    player.id == self.checkOutPlayer?.id ?? 0
                }
                
            }
        }
    }
    
    
    @Published var  tossdecision: Int? = nil
    @Published var  tosswinnerid: Int? = nil
    @Published var  noOfOvers: String = ""
    @Published var  oversPerBowler: String = ""
    
    @Published var  batting_team_id = 0
    @Published var  bowling_team_id = 0
    
    @Published var  battingTeamPlayers:[User] = []
    @Published var  bowlingTeamPlayers:[User] = []
    @Published var  tempBattingTeamPlayers:[User] = []
    @Published var  tempBowlingTeamPlayers:[User] = []
    
    @Published var  striker: User?
    @Published var  nonStriker: User?
    @Published var  bowler: User?
    @Published var  keeper: User?
 
    

    @Published var  totleScoreTeam1: String = "0/0"
    @Published var  totleScoreTeam2: String = "0/0"
    
    @Published var  scorePlayer1: String = "0(0)"
    @Published var  scorePlayer2: String = "0(0)"
    
    @Published var  matchPlayingTeam: String = "Team A"
    
    @Published var  playerRun: Int? = nil

    
    @Published var  btnWB: Bool = false
    @Published var  btnNB: Bool = false
    @Published var  btnBYB: Bool = false
    @Published var  btnLB: Bool = false
    @Published var  btnRun: Bool = false
    @Published var  btnUndo: Bool = false
    @Published var  btnOut: Bool = false
    
    @Published var  showBowlingListForNewBowler = 0
    @Published var  showBatingPlayerList = 0
    @Published var  changeInningView = false
    
    @Published var  checkOutPlayer: User?
    
    @Published var  viewWillAppear: Bool = false
    
    var battingTeamOutPlayerId:[User] = [User(id: 1,fullName: "A"),User(id: 2,fullName: "B")]
    
    func btnOutClick() {
        coordinator?.loadOutView(nearbyMatchesitem: nearbyMatchesitem!, 
                                 striker: striker!,
                                 nonStriker: nonStriker!,
                                 bowler: bowler!,
                                 batting_team_id: batting_team_id,
                                 bowling_team_id: bowling_team_id,
                                 response: { response, user,checkOutPlayer in
            self.checkOutPlayer = user
            self.response = response
            if checkOutPlayer {
                self.showBatingPlayerList = 1
            }else{
                self.showBatingPlayerList = 2
            }
        },playerList: bowlingTeamPlayers)
    }
    
    func updateCricketScorecard(model:UpdateCricketScorecardRequest) {
        showActivityIndicator = true
        circketServices.updateCricketScorecard(CricketScorecardResponce.self ,requset: model)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    guard let weakSelf = self else { return }
                    weakSelf.validationText = error.msg ?? ""
                    if error.msg == "Cannot permit bowler to bowl two consecutive overs."{
                        weakSelf.showBowlingListForNewBowler = 1
                    }else if error.msg == "Overs completed for inning. Please update inning"{
                        weakSelf.changeInning(model: UpdateStatusCricketRequest(match_id: weakSelf.nearbyMatchesitem?.id,innings: true))
                    }
                    weakSelf.showActivityIndicator = false
                default:
                    break
                }
            } receiveValue: { [weak self]  (response) in
                guard let weakSelf = self else { return }
                
                weakSelf.showActivityIndicator = false
                weakSelf.cricketScorecard = response.data
                weakSelf.setDataOnCard(response)
//                weakSelf.totleScoreTeam1 = "\(response.data?.team1Score ?? 0)/\(response.data?.team1Wickets ?? 0)"
//                weakSelf.totleScoreTeam2 = "\(response.data?.team2Score ?? 0)/\(response.data?.team2Wickets ?? 0)"
//                
//                weakSelf.striker?.fullName = response.data?.striker?.name ?? ""
//                weakSelf.striker?.id = response.data?.striker?.id ?? 0
//                weakSelf.scorePlayer1 = "\(response.data?.striker?.runs ?? 0)(\(response.data?.striker?.balls ?? 0))"
//                
//                weakSelf.nonStriker?.fullName = response.data?.nonStriker?.name ?? ""
//                weakSelf.nonStriker?.id = response.data?.nonStriker?.id ?? 0
//                weakSelf.scorePlayer2 = "\(response.data?.nonStriker?.runs ?? 0)(\(response.data?.nonStriker?.balls ?? 0))"
//                
//                if let ballList = response.data?.currentOverDetails?.balls{
//                    weakSelf.runsList = ballList
//                }
            }
            .store(in: &cancellableSet)
    }
    
    func outPlayer(response: CricketScorecardResponce) {
        cricketScorecard = response.data
        
        totleScoreTeam1 = "\(response.data?.team1Score ?? 0)/\(response.data?.team1Wickets ?? 0)"
        totleScoreTeam2 = "\(response.data?.team2Score ?? 0)/\(response.data?.team2Wickets ?? 0)"
        
        striker?.fullName = response.data?.striker?.name ?? ""
        striker?.id = response.data?.striker?.id ?? 0
        scorePlayer1 = "\(response.data?.striker?.runs ?? 0)(\(response.data?.striker?.balls ?? 0))"
        
        nonStriker?.fullName = response.data?.nonStriker?.name ?? ""
        nonStriker?.id = response.data?.nonStriker?.id ?? 0
        scorePlayer2 = "\(response.data?.nonStriker?.runs ?? 0)(\(response.data?.nonStriker?.balls ?? 0))"
        
        if let ballList = response.data?.currentOverDetails?.balls{
            runsList = ballList
        }
    }
    
    func changeInning(model: UpdateStatusCricketRequest) {
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
                
                weakSelf.changeInning()
            }
            .store(in: &cancellableSet)
    }
    
    func undoCricketAction(model: UndoReq) {
        showActivityIndicator = true
        circketServices.undoCricketAction(BaseResponce.self ,requset: model)
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
                
            } .store(in: &cancellableSet)
    }
    
    
    func addScore(run: Int? = nil){

        let model = UpdateCricketScorecardRequest(match_id: nearbyMatchesitem?.id,
                                                  action: "ball",
                                                  player_id: striker?.id,
                                                  off_strike_id: nonStriker?.id,
                                                  team_id: batting_team_id,
                                                  runs: run,
                                                  bowler_id: bowler?.id)
        updateCricketScorecard(model: model)
    }
    
    func addScoreWithExtraBall(run: Int? = nil, ballType:String){
        
        let model = UpdateCricketScorecardRequest(match_id: nearbyMatchesitem?.id,
                                                  action: "ball",
                                                  player_id: striker?.id,
                                                  off_strike_id: nonStriker?.id,
                                                  team_id: batting_team_id,
                                                  extra_type: ballType,
                                                  bowler_id: bowler?.id)
        updateCricketScorecard(model: model)
       
    }
    
    func extreBall(index: Int) -> Bool{
        let item = runsList[index]
        var check = false
        if item.wide ?? false{
            check = true
        }else if item.bye ?? false{
            check = true
        }
        else if item.noBall ?? false{
            check = true
        
        }else if item.legBye ?? false{
            check = true
        }
        return check
    }
    
    func balltype(index: Int) -> String{
        let item = runsList[index]
        var check = ""
        if item.wide ?? false{
            check = "wd"
        }else if item.bye ?? false{
            check = "by"
        }
        else if item.noBall ?? false{
            check = "no"
        
        }else if item.legBye ?? false{
            check = "le"
        }
        return check
    }
    
  
    func isViewWillAppearFirst(){
        tempBattingTeamPlayers = battingTeamPlayers
        tempBowlingTeamPlayers = bowlingTeamPlayers
        
        self.tempBattingTeamPlayers.removeAll { player in
            player.id == striker?.id || player.id == nonStriker?.id
        }
       
    }
    
    func removeSelectedPlayerFormBowlingList(){
        bowlingTeamPlayers =  bowlingTeamPlayers.map { user in
            var modifiedPlayer = user
            modifiedPlayer.isSelected = false
            return modifiedPlayer
            
        }
        tempBowlingTeamPlayers = bowlingTeamPlayers
        self.tempBowlingTeamPlayers.removeAll { player in
            player.id == bowler?.id || player.id == keeper?.id
        }
       
    }
    
    func setDataOnCard(_ cricketScorecard: CricketScorecardResponce){
        self.cricketScorecard = cricketScorecard.data
        totleScoreTeam1 = "\(cricketScorecard.data?.team1Score ?? 0)/\(cricketScorecard.data?.team1Wickets ?? 0)"
        totleScoreTeam2 = "\(cricketScorecard.data?.team2Score ?? 0)/\(cricketScorecard.data?.team2Wickets ?? 0)"
        
        striker?.fullName = cricketScorecard.data?.striker?.name ?? ""
        striker?.id = cricketScorecard.data?.striker?.id ?? 0
        scorePlayer1 = "\(cricketScorecard.data?.striker?.runs ?? 0)(\(cricketScorecard.data?.striker?.balls ?? 0))"
        
        nonStriker?.fullName = cricketScorecard.data?.nonStriker?.name ?? ""
        nonStriker?.id = cricketScorecard.data?.nonStriker?.id ?? 0
        scorePlayer2 = "\(cricketScorecard.data?.nonStriker?.runs ?? 0)(\(cricketScorecard.data?.nonStriker?.balls ?? 0))"
        
        if let ballList = cricketScorecard.data?.currentOverDetails?.balls{
            runsList = ballList
        }
    }
    
    
    func changeInning(){

        coordinator?.loadStartInningsView(nearbyMatchesitem: nearbyMatchesitem!,
                                          battingTeamPlayers: battingTeamPlayers,
                                          bowlingTeamPlayers: bowlingTeamPlayers,
                                          batting_team_id: batting_team_id,
                                          bowling_team_id:bowling_team_id,
                                          
                                                   changeInning: { model in
            self.striker = model.striker ?? User()
            self.nonStriker = model.nonStriker ?? User()
            self.bowler = model.bowler ?? User()
            self.keeper = model.keeper ?? User()
            self.runsList = []
            self.scorePlayer1 = "0"
            self.scorePlayer2 = "0"
            self.totleScoreTeam1 = "0/0"
            self.cricketScorecard?.currentOver  = 0
            self.cricketScorecard?.currentBall = 0
            self.matchPlayingTeam = model.matchPlayingTeam ?? "Team"
            self.changeInningTeamSwap()
        })
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
        
        tempBattingTeamPlayers = battingTeamPlayers
        tempBowlingTeamPlayers = bowlingTeamPlayers
        self.tempBattingTeamPlayers.removeAll { player in
            player.id == striker?.id || player.id == nonStriker?.id
        }
    }

    
    func testOut(){
        
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

          setDataOnCard(cricketScorecard)
          changeInning()
      }
      
}

 

