//
//  TennisScoreCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 29/05/2024.
//

import SwiftUI

struct TennisScoreCardViews: View {
    var cardType:ScoreCardType = .BadmintonScoreCard
    var body: some View {
        VStack(spacing: 0){
            HomeSecondaryAppBBar(title: StringConstants.badmintonScoreCard,showUndoButton: true, btnShareCallBack:  {
                
            }).padding(.top,5)
            SetView()
            VStack(spacing: 30){
                if cardType == .TennisScoreCard {
                    SetCardView().padding(.top,30)
                }
                TeamCardView().padding(.top,cardType == .TennisScoreCard ? 0 : 100)
                HStack{
                    ButtonCardView()
                    Spacer()
                    ButtonCardView()
                }
                SetCardView()
                Spacer()
                AppButton(title: StringConstants.startMatch) {
                    
                }
            }.padding(.horizontal)
          
        }
    }
}

#Preview {
    TennisScoreCardViews()
}
