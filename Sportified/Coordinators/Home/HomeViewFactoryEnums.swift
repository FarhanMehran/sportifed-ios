//
//  HomeViewFactoryEnums.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import Foundation
import Foundation
import UIKit
import SwiftUI

extension ViewFactory {
    
    enum Home {
        case tabbarView(coordinator: HomeCoordinator)
        case gameView(viewModel: GameViewModel)
        case detailView(viewModel: DetailViewModel)
        case createGameView(viewModel: CreateGameViewModel)
        case profileView(viewModel: ProfileViewModel)
        case createGroupView(viewModel: CreateGroupViewModel)
        case chatView(viewModel: ChatViewModel)
        case preferencesView(viewModel: PreferencesViewModel)
        case matchesScoreView(viewModel: MatchesScoreViewModel)
        case scoreCardView(viewModel: ScoreCardViewModel)
        case creatTournamentView(viewModel: CreatTournamentViewModel)
        case startCircketMatchView(viewModel: StartCircketMatchViewModel)
        case tossView(viewModel: TossViewModel)
        case startInningsView(viewModel: StartInningsViewModel)
        case scoringViewScoringView(viewModel: StartCircketMatchViewModel)
        case cricketScoringView(viewModel: CricketScoreCardsViewModel)
        case outView(viewModel: OutViewModel)
        case cricketSummaryView(viewModel: CricketScoreCardSummaryViewModel)
        case outType(viewModel: OutTypeViewModel)
        case startAMatchFootBallView(viewModel: StartAMatchFootBallViewModel)
        case footballScoreCardView(viewModel: FootballScoreCardViewModel)
        case footballScoreCardSummaryView(viewModel: FootballScoreCardSummaryViewModel)
        case startMatchBasketballScoreCardsView(viewModel: StartMatchBasketballScoreCardsViewModel)
        case basketballScoreMakeCardView(viewModel: BasketballScoreMakeCardViewModel)

    
        var viewController: UIViewController {
            switch self {
            case .tabbarView(let viewModel):
                return UIHostingController(rootView: TabbarView(coordinator: viewModel))
            case .gameView(let viewModel):
                return UIHostingController(rootView: GameView(viewModel: viewModel))
            case .detailView(let viewModel):
                return UIHostingController(rootView: DetailView(viewModel: viewModel))
            case .createGameView(let viewModel):
                return UIHostingController(rootView: CreateGameView(viewModel: viewModel))
            case .profileView(let viewModel):
                return UIHostingController(rootView: ProfileSettingsView(viewModel: viewModel))
            case .createGroupView(let viewModel):
                return UIHostingController(rootView: CreateGroupView(viewModel: viewModel))
            case .chatView(let viewModel):
                return UIHostingController(rootView: ChatView(viewModel: viewModel))
            case .preferencesView(let viewModel):
                return UIHostingController(rootView: PreferencesView(viewModel: viewModel))
            case .matchesScoreView(let viewModel):
                return UIHostingController(rootView: MatchesScoreView(viewModel: viewModel))
            case .scoreCardView(let viewModel):
                return UIHostingController(rootView: ScoreCardView(viewModel: viewModel))
            case .creatTournamentView(let viewModel):
                return UIHostingController(rootView: CreatTournamentView(viewModel: viewModel))
            case .startCircketMatchView(let viewModel):
                return UIHostingController(rootView: StartCircketMatchView(viewModel: viewModel))
            case .tossView(let viewModel):
                return UIHostingController(rootView: TossView(viewModel: viewModel))
            case .startInningsView(let viewModel):
                return UIHostingController(rootView: StartInningsView(viewModel: viewModel))
            case .cricketScoringView(let viewModel):
                return UIHostingController(rootView: CricketScoringView(viewModel: viewModel))
            case .scoringViewScoringView(viewModel: let viewModel):
                return UIHostingController(rootView: StartCircketMatchView(viewModel: viewModel))
            case .outView(viewModel: let viewModel):
                return UIHostingController(rootView: OutView(viewModel: viewModel))
            case .cricketSummaryView(viewModel: let viewModel):
                return UIHostingController(rootView: CricketScoreCardSummaryView(viewModel: viewModel))
            case .outType(viewModel: let viewModel):
                return UIHostingController(rootView: OutTypeView(viewModel: viewModel))
            case .startAMatchFootBallView(viewModel: let viewModel):
                return UIHostingController(rootView: StartAMatchFootBallView(viewModel: viewModel))
            case .footballScoreCardView(viewModel: let viewModel):
                return UIHostingController(rootView: FootballScoreCardView(viewModel: viewModel))
            case .footballScoreCardSummaryView(viewModel: let viewModel):
                return UIHostingController(rootView: FootballScoreCardSummaryView(viewModel: viewModel))
            case .startMatchBasketballScoreCardsView(viewModel: let viewModel):
                return UIHostingController(rootView: StartMatchBasketballScoreCards(viewModel: viewModel))
            case .basketballScoreMakeCardView(viewModel: let viewModel):
                return UIHostingController(rootView: BasketballScoreMakeCardView(viewModel: viewModel))
            }
        }
    }
}
