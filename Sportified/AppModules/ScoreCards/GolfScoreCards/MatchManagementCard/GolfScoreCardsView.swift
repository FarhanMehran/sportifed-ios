//
//  GolfScoreCardsView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 21/08/2024.
//

import SwiftUI

struct GolfScoreCardsView: View {
    var body: some View {
        VStack(spacing: 0){
            
            HomeSecondaryAppBBar(title: "Score Card",showUndoButton: true, btnShareCallBack:  {
                
            }).padding(.top,5)
            
            ScrollView(showsIndicators: false){
                VStack(spacing:0){
                    HStack(spacing: 10){
                        GolfButtonCardView(title: "Front")
                        Spacer()
                        GolfButtonCardView(title: "Back")
                    }.padding(.top,10).padding(.horizontal,40)
                    ZStack{
                        VStack(spacing:0){
                            HStack{
                               
                                Text("Hole") .foregroundColor(.white) .font(.mulishBold(size: 15))
                                    .frame(width: 45)
                                Color.white.frame(width: 0.5)
                                Text("Par") .foregroundColor(.white) .font(.mulishBold(size: 15))
                                    .frame(width: 45)
                                Color.white.frame(width: 0.5)
                                Text("One") .foregroundColor(.white) .font(.mulishBold(size: 15))
                                    .frame(width: 45)
                                Color.white.frame(width: 0.5)
                                Text("Two") .foregroundColor(.white) .font(.mulishBold(size: 15))
                                    .frame(width: 45)
                                Color.white.frame(width: 0.5)
                                Text("Three") .foregroundColor(.white) .font(.mulishBold(size: 15))
                                    .frame(width: 45)
                                Color.white.frame(width: 0.5)
                                Text("Four") .foregroundColor(.white) .font(.mulishBold(size: 15))
                                    .frame(width: 45)
                                
                            }.frame(height: 35).background(Color.appGreen).cornerRadius(10, corners: [.topLeft,.topRight]).padding(.horizontal).padding(.top,20)
                            
                            VStack(spacing: 0){
                                ForEach(0..<10, id: \.self){ index in
                                    VStack(spacing: 0){
                                        HStack{
                                            
                                            Text("-") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                                .frame(width: 45).padding(.vertical)
                                            Color.textColorGray.frame(width: 0.5)
                                            Text("-") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                                .frame(width: 45)
                                            Color.textColorGray.frame(width: 0.5)
                                            Text("-") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                                .frame(width: 45)
                                            Color.textColorGray.frame(width: 0.5)
                                            Text("-") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                                .frame(width: 45)
                                            Color.textColorGray.frame(width: 0.5)
                                            Text("-") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                                .frame(width: 45)
                                            Color.textColorGray.frame(width: 0.5)
                                            Text("-") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                                .frame(width: 45)
                                            
                                        }
                                        
                                        if index != 9{
                                            Color.textColorGray.frame(height: 0.5)
                                        }
                                    }
                                }
                            }.overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.textColorGray, lineWidth: 0.5)).padding(.horizontal,20)
                                
                        }
                    }
                    AppButton(title: "Next", callBack: {
                        
                        
                    }).padding(.top,50).padding(.horizontal)
                }.padding(.top)
            }
        }
    }
}

#Preview {
    GolfScoreCardsView()
}
struct GolfButtonCardView: View {
    var title:String = "+"
    var width:CGFloat = 105
    var body: some View {
        Button {
            
        } label: {
            
            Text(title).font(.mulishMedium(size: 15))
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .foregroundColor(Color.appGreenColor).overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.appGreen, lineWidth: 1))
            
        }

        
    }
}
