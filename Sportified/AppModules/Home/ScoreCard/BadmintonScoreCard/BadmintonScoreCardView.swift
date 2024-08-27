//
//  BadmintonScoreCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 29/05/2024.
//

import SwiftUI
enum ScoreCardType{
    case BadmintonScoreCard
    case TennisScoreCard
    case BasketballScoreCard
    case soccerScoreCard
}

struct SetView: View {
    var selectedItem = 2
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<3) { index in
                Text("1 Set")
                    .font(Font.custom("Mulish-Medium", size: 24))
                    .frame(width: 93, height: 68)
                    .background(selectedItem == index ? Color.appGreen : Color.clear)
                    .foregroundColor(selectedItem == index ? Color.white : Color.appGreen)
                if index != 2{
                    Divider()
                }
            }
        }
        .frame(width: 280, height: 68)
        .background(Color.textFieldColor)
        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
    }
}

struct SetCardView: View {
    var title:String = "Games won in current set"
    var selectedItem = 2
    var body: some View {
        VStack {
            
                Text(title)
                    .font(Font.custom("Mulish-Medium", size: 24)).foregroundColor(Color.textColor)
            HStack{
                Text("1 ").font(.mulishMedium(size: 48)).foregroundColor(Color.appGreen)
                Text("x").font(.mulishMedium(size: 36)).foregroundColor(Color.gray)
                Text("1 ").font(.mulishMedium(size: 48)).foregroundColor(Color.appGreen)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(Color.textFieldColor)
        .cornerRadius(15)
    }
}


struct TeamCardView: View {
    
    var body: some View {
        HStack {
            VStack(spacing: 10){
                Text("Team 1").font(.mulishMedium(size: 24)).foregroundColor(Color.textColor)
                Text("54").font(.mulishMedium(size: 64)).foregroundColor(Color.appGreen)
            }
            Spacer()
            Text("x").font(.mulishMedium(size: 64)).foregroundColor(Color.gray)
            Spacer()
            VStack(spacing: 10){
                Text("Team 1").font(.mulishMedium(size: 24)).foregroundColor(Color.textColor)
                Text("54").font(.mulishMedium(size: 64)).foregroundColor(Color.appGreen)
            }
        }.padding(.horizontal,25)
        .frame(maxWidth: .infinity)
        .frame(height: 170)
        .background(Color.textFieldColor)
        .cornerRadius(15)
    }
}
struct ButtonCardView: View {
    var title:String = "+"
    var width:CGFloat = 95
    var body: some View {
        Button {
            
        } label: {
            
            Text(title).offset(y:-3).font(.mulishMedium(size: 30)).foregroundColor(Color.gray)
                .frame(width: width).overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.appGreen, lineWidth: 1))
            
        }

        
    }
}
