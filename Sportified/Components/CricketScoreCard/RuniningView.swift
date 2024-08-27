//
//  RuniningView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/05/2024.
//

import SwiftUI

struct RuniningView: View {
    var isShowLine = false
    var changeColor = false
    var height:CGFloat = 20
    var playerName = "Batsman"
    var r = "R"
    var b = "B"
    var s4 = "4s"
    var s6 = "6s"
    var sr = "SR"
    var body: some View {
        VStack(spacing:5){
            
            HStack{
                
                Text(playerName).font(Font.mulishMedium(size: 15)).foregroundColor(changeColor ? Color.white : Color.textColorGray).padding(.leading)
                Spacer()
                HStack(spacing: 0){
                    Text(r).font(Font.mulishMedium(size: 15)).foregroundColor(changeColor ? Color.white : Color.textColorGray)
                        .frame(width: 35)
                    Text(b).font(Font.mulishMedium(size: 15)).foregroundColor(changeColor ? Color.white : Color.textColorGray)
                        .frame(width: 35)
                    Text(s4).font(Font.mulishMedium(size: 15)).foregroundColor(changeColor ? Color.white : Color.textColorGray)
                        .frame(width: 35)
                    Text(s6).font(Font.mulishMedium(size: 15)).foregroundColor(changeColor ? Color.white : Color.textColorGray)
                        .frame(width: 35)
                    Text(sr).font(Font.mulishMedium(size: 15)).foregroundColor(changeColor ? Color.white : Color.textColorGray)
                        .frame(width: 35)
                  
                }.padding(.trailing)
            }.frame(height: height).background(changeColor ? Color.appGreenColor : .clear).cornerRadius(10)
            if isShowLine{
                CustomDivider(height: 1).padding(.top,5)
            }
        }
    }
}

#Preview {
    CricketScoreCardSummaryView(viewModel: CricketScoreCardSummaryViewModel())
}
