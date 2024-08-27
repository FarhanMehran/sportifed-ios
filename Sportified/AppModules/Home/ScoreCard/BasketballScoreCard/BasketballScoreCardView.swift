//
//  BasketballScoreCardView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 29/05/2024.
//

import SwiftUI

struct BasketballScoreCardView: View {
    var cardType:ScoreCardType = .soccerScoreCard
    var body: some View {
        VStack(spacing: 0){
            HomeSecondaryAppBBar(title: StringConstants.badmintonScoreCard,showUndoButton: true, btnShareCallBack:  {
                
            }).padding(.top,5)
            TimerView()
            VStack(spacing: 30){
                
                
                
                TeamCardView().padding(.top,100)
                if cardType == .BasketballScoreCard{
                    HStack{
                        
                        BasketButtonCardView()
                        BasketButtonCardView()
                        BasketButtonCardView()
                        BasketButtonCardView().padding(.leading)
                        BasketButtonCardView()
                        BasketButtonCardView()
                    }
                }else if cardType == .soccerScoreCard{
                    HStack{
                        ButtonCardView()
                        Spacer()
                        ButtonCardView()
                    }
                }
                BasketballSetCardView()
                Spacer()
                AppButton(title: StringConstants.publish) {
                    
                }
            }.padding(.horizontal)
            
        }
    }
}

#Preview {
    BasketballScoreCardView()
}

struct BasketButtonCardView: View {
    
    var body: some View {
        Button {
            
        } label: {
            
            Text("+2").font(.mulishMedium(size: 24)).foregroundColor(Color.appGreen)
                .frame(width: 50).overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.appGreen, lineWidth: 1))
            
        }

        
    }
}


struct TimerView: View {
    var time:String = "00 : 00"
    var isCheck:Bool = false
    var callBack:(()->Void)?
    var body: some View {
        HStack(spacing: 25) {
            if isCheck{
                Image("play").resizable().frame(width: 40,height: 40).onTapGesture {
                    callBack?()
                }
            }else{
                Image(systemName: "pause.circle").resizable().frame(width: 40,height: 40).foregroundColor(Color.appGreenColor).onTapGesture {
                    callBack?()
                }
               
            }
            Text(time).font(.mulishMedium(size: 48)).foregroundColor(Color.appGreen)
           // Text(":").font(.mulishMedium(size: 48)).foregroundColor(Color.appGreen)
            //Text("10").font(.mulishMedium(size: 48)).foregroundColor(Color.appGreen)
        }
        .frame(width: 280, height: 68)
        .background(Color.textFieldColor)
        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
    }
}

struct BasketballSetCardView: View {
    var selectedItem = 2
    var body: some View {
        HStack{
           
        VStack {
            
            Text("1 Set")
                .font(Font.custom("Mulish-Medium", size: 24)).foregroundColor(Color.textColor)
            HStack(spacing: 25){
                ButtonCardView(width: 80)
                Text("1").font(.mulishMedium(size: 48)).foregroundColor(Color.appGreen)
                Text("x").font(.mulishMedium(size: 36)).foregroundColor(Color.gray)
                Text("1").font(.mulishMedium(size: 48)).foregroundColor(Color.appGreen)
                ButtonCardView(width: 80).frame(width: 60)
            }
        }
           
    }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(Color.textFieldColor)
        .cornerRadius(15)
    }
}
