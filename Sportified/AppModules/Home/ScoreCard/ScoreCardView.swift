//
//  ScoreCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 02/05/2024.
//

import SwiftUI

struct ScoreCardView: View {
    @ObservedObject var viewModel: ScoreCardViewModel
    var body: some View {
        ZStack{
            VStack{
                HomeSecondaryAppBBar(title: StringConstants.scoreCard, showUndoButton: true,btnBackCallBack: {
                    viewModel.coordinator?.popNavigationView()
                }).padding(.top,5)
                
                CricketScoreCardView()
            }
        }
    }
}

#Preview {
    ScoreCardView(viewModel: ScoreCardViewModel())
}
struct ScoreCardViewsubView: View {
    var body: some View {
        VStack{
            
           
            
            VStack(alignment: .leading,spacing: 10){
               
                Text("Team 1").font(Font.mulishMedium(size: 18)).padding(.top,20).foregroundColor(Color.textColor)
                AuthTextField(title: StringConstants.teamName,type: .normalField ,text: .constant(""))
                Text("Team 2").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top)
                AuthTextField(title: StringConstants.teamName,type: .normalField ,text: .constant(""))
                Text(StringConstants.overs).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top)
                AppButton(title: "20",buttonType: .dropDown) {
                    
                }
                Text(StringConstants.batFirst).font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor).padding(.top)
                AppButton(title: "Team 1",buttonType: .dropDown) {
                    
                }
                Spacer()
                AppButton(title: StringConstants.startMatch) {
                    
                }
            }.padding(.horizontal)
        }
    }
}
