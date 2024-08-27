//
//  TennisScoreCardViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 19/08/2024.
//

import Foundation
class TennisScoreCardViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    @Published var nearbyMatchesitem: NearbyMatchesList?
    
    @Published var isShowHandicap: Bool = false
    
    @Published var currentGame: String? = nil
    @Published var isShowcurrentGame: Bool = false
    @Published  var currentGameList:[SelectedDate] = [SelectedDate(name: "Game 1", isSelected: false),
                                                      SelectedDate(name: "Game 1", isSelected: false)]
    
    @Published var advantage : String? = nil
    @Published var isShowAdvantage : Bool = false
    @Published var advantageList:[SelectedDate] = [SelectedDate(name: "Best of 3 games", isSelected: false),
                                                    SelectedDate(name: "Best of 5 games ", isSelected: false)]
    
    @Published var pointstoWin : String? = nil
    @Published var isShowPointstowin : Bool = false
    @Published var pointstowinList:[SelectedDate] = [SelectedDate(name: "11 Points (Standard PAR)", isSelected: false),
                                                     SelectedDate(name: "9 Points (Traditional HIHO)", isSelected: false)]
}
