//
//  CricketScoreCardSummary.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/08/2024.
//

import SwiftUI

struct CricketScoreCardSummaryView: View {
    @ObservedObject var viewModel: CricketScoreCardSummaryViewModel
    var body: some View {
       
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator,title: StringConstants.cricketScoreCard, btnShareCallBack:  {
                    
                }).padding(.top,5)
                ScrollView(showsIndicators: false){
                
                CricketScoreCardSecondSubView(model: viewModel.cricketScoreCardSummary).padding(.top).padding(.horizontal)
            }.onAppear{
                viewModel.getcricketScoreCardSummary()
            }
        }
    }
}

#Preview {
    CricketScoreCardSummaryView(viewModel: CricketScoreCardSummaryViewModel())
}
