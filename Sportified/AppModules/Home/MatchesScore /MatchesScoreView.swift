//
//  MatchesScoreView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI
enum MatchesScoreRoutType{
    case scoreCard
    case matchesScore
    case myGame
}
struct MatchesScoreView: View {
    
    @ObservedObject var viewModel: MatchesScoreViewModel
    
    var body: some View {
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(title: viewModel.title , btnBackCallBack:  {
                    viewModel.coordinator?.popNavigationView()
                }).padding(.top,5)
                
                FilterTabbarView(filterCallBack: {
                    viewModel.sort =  false
                },sortCallBack: {
                    viewModel.sort =  true
                })
                
                ScrollView(showsIndicators: false){
                    VStack(spacing: 20){
                        ForEach(0..<viewModel.temmatchesList.count, id: \.self){ index in
                            let item = viewModel.temmatchesList[index]
                            if index == 2 {
                                ImageSliderView().cornerRadius(20)
                            }
                            NearbyGamesListView (model: item, callBack: {
                                if viewModel.routType == .matchesScore{
                                    //now check on id but need with name
                                    if item.sportName == GameTypes.cricket.rawValue {
                                        viewModel.coordinator?.loadCricketScoreCardSummaryView(nearbyMatchesitem: BaseData.shared.temmatchesList[index])
                                    }
                                }else{
                                    viewModel.coordinator?.loadHomeDetailView(routType: .MatchesScore, nearbyMatchesitem: item,callBack: {_ in})
                                }
                            })                    }
                    }.padding(.horizontal).padding(.top)
                }
                
                Spacer()
            }.onAppear{
                viewModel.onAppear()
            //    viewModel.getSportsNearby()
            }
            if viewModel.showActivityIndicator {
                ActivityIndicator()
            }
        }
    }
}

#Preview {
    MatchesScoreView(viewModel: MatchesScoreViewModel())
}
