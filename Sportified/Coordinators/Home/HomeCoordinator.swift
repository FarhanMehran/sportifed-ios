//
//  HomeCoordinator.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

public class HomeCoordinator {
    
    var parentCoordinator: AuthCoordinator?
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        
       loadTabBarView()
        
      //test()
       // loadStartAMatchFootBallView()
       
        //ScoringView()
       // loadCricketScoreCardsView()
    }
    
    func popNavigationView() {
        self.navigationController.popViewController(animated: true)
    }
    
    func loadTabBarView() {
        let viewController = ViewFactory.Home.tabbarView(coordinator: self).viewController
        navigationController.viewControllers = [viewController]
        
    }
    
    func loadGameView() {
        let viewModel = GameViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Home.gameView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadHomeDetailView(routType: DetailViewRoutType = .home,nearbyMatchesitem: NearbyMatchesList, callBack: @escaping (NearbyMatchesList)->Void) {
        let viewModel = DetailViewModel()
        viewModel.coordinator = self
        viewModel.routType = routType
        viewModel.nearbyMatchesitem = nearbyMatchesitem
        viewModel.callBack = callBack
        let viewController = ViewFactory.Home.detailView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadCreatGame(routType: CreateGameType = .createGame, nearbyMatchesitem: NearbyMatchesList? = nil, callBackUpdateData: @escaping ((NearbyMatchesList)->Void)) {
        let viewModel = CreateGameViewModel()
        viewModel.coordinator = self
        viewModel.routType = routType
        viewModel.nearbyMatchesitem = nearbyMatchesitem
        viewModel.callBack = callBackUpdateData
        let viewController = ViewFactory.Home.createGameView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadCreatTournament() {
        let viewModel = CreatTournamentViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Home.creatTournamentView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadCreateGroupView(callback: @escaping (GetAllChatsResponse)->Void) {
        let viewModel = CreateGroupViewModel()
        viewModel.coordinator = self
        viewModel.callBack = callback
        let viewController = ViewFactory.Home.createGroupView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadProfileView() {
        let viewModel = ProfileViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Home.profileView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadChatView(item:GetlCommunityResponce,callBack: @escaping ((String)->Void)) {
        let viewModel = ChatViewModel()
        viewModel.coordinator = self
        viewModel.item = item
        viewModel.callBack = callBack
        WebSocketManager.shared.delegate = viewModel.self
        let viewController = ViewFactory.Home.chatView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadPreferencesView() {
        let viewModel = PreferencesViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Home.preferencesView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadMatchesScoreView(routType: MatchesScoreRoutType = .scoreCard) {
        let viewModel = MatchesScoreViewModel()
        viewModel.coordinator = self
        viewModel.routType = routType
        let viewController = ViewFactory.Home.matchesScoreView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadScoreCardView() {
        let viewModel = ScoreCardViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Home.scoreCardView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadStartCircketMatchView(model: NearbyMatchesList) {
        let viewModel = StartCircketMatchViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = model
        let viewController = ViewFactory.Home.startCircketMatchView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadTossView(nearbyMatchesitem: NearbyMatchesList, noOfOvers:String,oversPerBowler:String) {
        let viewModel = TossViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = nearbyMatchesitem
        viewModel.noOfOvers = noOfOvers
        viewModel.oversPerBowler = oversPerBowler
        let viewController = ViewFactory.Home.tossView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadStartInningsView(nearbyMatchesitem: NearbyMatchesList, tosswinnerid: Int ,tossdecision: Int, noOfOvers: String,
                              batting_team_id:Int,bowling_team_id:Int,oversPerBowler:String) {
        let viewModel = StartInningsViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = nearbyMatchesitem
        viewModel.tosswinnerid = tosswinnerid
        viewModel.tossdecision = tossdecision
        viewModel.noOfOvers = noOfOvers
        viewModel.oversPerBowler = oversPerBowler
        viewModel.batting_team_id = batting_team_id
        viewModel.bowling_team_id = bowling_team_id
        let viewController = ViewFactory.Home.startInningsView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    func loadCricketScoreCardsView(nearbyMatchesitem: NearbyMatchesList,
                                   tosswinnerid: Int ,
                                   tossdecision: Int,
                                   noOfOvers: String,
                                   oversPerBowler: String,
                                   striker: User,
                                   nonStriker: User,
                                   bowler: User,
                                   keeper: User,
                                   matchPlayingTeam: String,
                                   batting_team_id:Int,
                                   bowling_team_id:Int,
                                   battingTeamPlayers:[User],
                                   bowlingTeamPlayers:[User]) {
        

        let viewModel = CricketScoreCardsViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = nearbyMatchesitem
        viewModel.tosswinnerid = tosswinnerid
        viewModel.tossdecision = tossdecision
        viewModel.noOfOvers = noOfOvers
        viewModel.striker = striker
        viewModel.nonStriker = nonStriker
        viewModel.bowler = bowler
        viewModel.keeper = keeper
        viewModel.oversPerBowler = oversPerBowler
        viewModel.matchPlayingTeam = matchPlayingTeam
        viewModel.bowling_team_id = bowling_team_id
        viewModel.battingTeamPlayers = battingTeamPlayers
        viewModel.bowlingTeamPlayers = bowlingTeamPlayers
        let viewController = ViewFactory.Home.cricketScoringView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
    }  
    
    func loadStartInningsView(nearbyMatchesitem: NearbyMatchesList, battingTeamPlayers:[User], bowlingTeamPlayers:[User],
                              batting_team_id: Int,
                              bowling_team_id:Int,
                              changeInning: @escaping ((ChangeInningModel)->Void)
                              ) {
        let viewModel = StartInningsViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = nearbyMatchesitem
        viewModel.changeInning = changeInning
        viewModel.routType = .changeInning
        viewModel.battingTeamPlayers = battingTeamPlayers
        viewModel.bowlingTeamPlayers = bowlingTeamPlayers
        viewModel.batting_team_id = batting_team_id
        viewModel.bowling_team_id = bowling_team_id
        let viewController = ViewFactory.Home.startInningsView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func loadOutView(nearbyMatchesitem: NearbyMatchesList,
                     striker: User,
                     nonStriker: User,
                     bowler: User,
                     batting_team_id: Int,bowling_team_id: Int,
                     response: @escaping ((CricketScorecardResponce,User,Bool)->Void),playerList:[User]) {
        let viewModel = OutViewModel()
        viewModel.coordinator = self
        viewModel.getResponse = response
        viewModel.batting_team_id = batting_team_id
        viewModel.bowling_team_id = bowling_team_id
        viewModel.bowler = bowler
        viewModel.nonStriker = nonStriker
        viewModel.striker = striker
        viewModel.nearbyMatchesitem = nearbyMatchesitem
        viewModel.playerList = playerList
        let viewController = ViewFactory.Home.outView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadLoginView() {
        let authCoordinator = AuthCoordinator(navigationController: self.navigationController)
        authCoordinator.loadLoginView()
    }
    
    func loadCricketScoreCardsView() {
        let viewModel = CricketScoreCardsViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Home.cricketScoringView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func loadCricketScoreCardSummaryView(nearbyMatchesitem: NearbyMatchesList) {
        let viewModel = CricketScoreCardSummaryViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = nearbyMatchesitem
        let viewController = ViewFactory.Home.cricketSummaryView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func loadOutTypeView(outTypeCallBack: @escaping ((String)->Void)) {
        let viewModel = OutTypeViewModel()
        viewModel.coordinator = self
        viewModel.outTypeCallBack = outTypeCallBack
        let viewController = ViewFactory.Home.outType(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func loadStartAMatchFootBallView(model: NearbyMatchesList) {
        let viewModel = StartAMatchFootBallViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = model
        let viewController = ViewFactory.Home.startAMatchFootBallView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadFootballScoreCardView(model: NearbyMatchesList,matchTime:Int) {
        let viewModel = FootballScoreCardViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = model
        viewModel.selectedMatchTime = matchTime
        let viewController = ViewFactory.Home.footballScoreCardView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadFootballScoreCardSummaryView() {
        let viewModel = FootballScoreCardSummaryViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Home.footballScoreCardSummaryView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadStartMatchBasketballScoreCardsView() {
        let viewModel = StartMatchBasketballScoreCardsViewModel()
        viewModel.coordinator = self
        //viewModel.nearbyMatchesitem = model
        let viewController = ViewFactory.Home.startMatchBasketballScoreCardsView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func loadBasketballScoreMakeCardView(model: NearbyMatchesList,matchTime:Int) {
        let viewModel = BasketballScoreMakeCardViewModel()
        viewModel.coordinator = self
        viewModel.nearbyMatchesitem = model
        viewModel.selectedMatchTime = matchTime
        let viewController = ViewFactory.Home.basketballScoreMakeCardView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
//    func test() {
//        let viewModel = StartCircketMatchViewModel()
//        viewModel.coordinator = self
//        let viewController = ViewFactory.Home.startCircketMatchView(viewModel: viewModel).viewController
//        navigationController.pushViewController(viewController, animated: true)
//        
//    }
    func test() {
        let viewModel = StartMatchBasketballScoreCardsViewModel()
        viewModel.coordinator = self
        let viewController = ViewFactory.Home.startMatchBasketballScoreCardsView(viewModel: viewModel).viewController
        navigationController.pushViewController(viewController, animated: true)
        
    }
//    func test() {
//        let viewModel = FootballScoreCardViewModel()
//        viewModel.coordinator = self
//
//        let viewController = ViewFactory.Home.footballScoreCardView(viewModel: viewModel).viewController
//        navigationController.pushViewController(viewController, animated: true)
//        
//    }
}
