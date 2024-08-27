//
//  GolfScoreCardsSummryView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 20/08/2024.
//

import SwiftUI

struct GolfScoreCardsSummryView: View {
    var body: some View {
        VStack(spacing: 0){
            HomeSecondaryAppBBar(title: "Score Card",showUndoButton: true, btnShareCallBack:  {
                
            }).padding(.top,5)
            ScrollView(showsIndicators: false){
                
               
                ZStack{
                    VStack(spacing: 20){
                       
                        GolfScoreCards().padding(.top)
                        
                        GolfScoreCards().padding(.top,20)
                        
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    GolfScoreCardsSummryView()
}
struct GolfScoreCards: View {
    var body: some View {
        VStack(spacing:0){
            HStack{
                
                Text("Game") .foregroundColor(.white) .font(.mulishBold(size: 15))
                    .frame(width: 50).padding(.leading)
                Text("Par") .foregroundColor(.white) .font(.mulishBold(size: 15))
                    .frame(width: 40)
                Text("One") .foregroundColor(.white) .font(.mulishBold(size: 15))
                    .frame(width: 40)
                Text("Two") .foregroundColor(.white) .font(.mulishBold(size: 15))
                    .frame(width: 40)
                Text("Three") .foregroundColor(.white) .font(.mulishBold(size: 15))
                    .frame(width: 50)
                Text("Four") .foregroundColor(.white) .font(.mulishBold(size: 15))
                    .frame(width: 60)
            }.frame(height: 45)
                .background(Color.appGreen).cornerRadius(10, corners: [.topLeft,.topRight]).padding(.horizontal)
            
            //HStack(spacing:0){
            
            VStack(spacing:0){
                ForEach(0..<10, id: \.self){ index in
                    //let data = viewModel.goleLsit[index]
                    VStack(spacing:0){
                        HStack{
                            
                            Text("1") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                .frame(width: 50).padding(.leading)
                            Text("2") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                .frame(width: 40)
                            Text("3") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                .frame(width: 40)
                            Text("4") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                .frame(width: 40)
                            Text("5") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                .frame(width: 50)
                            Text("6") .foregroundColor(.textColor) .font(.mulishBold(size: 15))
                                .frame(width: 60)
                        }.frame(height: 50)
                            .background(index % 2 != 0 ? Color.textFieldColor.opacity(0.4) : .clear)
                        
                        
                    }.frame(height: 50)
                }
            } .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.textColorGray.opacity(0.2), lineWidth: 0.5)).padding(.horizontal).offset(y: -3)
        }
    }
}
