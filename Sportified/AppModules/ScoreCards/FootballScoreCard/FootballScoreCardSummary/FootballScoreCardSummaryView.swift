//
//  FootballScoreCardSummaryView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 24/07/2024.
//

import SwiftUI

struct FootballScoreCardSummaryView: View {
    @ObservedObject var viewModel: FootballScoreCardSummaryViewModel
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing:0){
                
                HomeSecondaryAppBBar(title: "Football Score Card", btnShareCallBack:  {
                    
                }).padding(.top,5)
                
                HStack(spacing: 25) {
                    VStack{
                        HStack{
                            
                        }.frame(width: 40,height: 40).background(Color.appGray).clipShape(.circle)
                        Text(viewModel.team1) .foregroundColor(.textColorGray) .font(.mulishRegular(size: 15.0))
                    }.padding(.bottom,5).frame(width: 70,height: 30)
                    Spacer()
                    VStack{
                        Text("\(viewModel.modelData?.data?.team1Score ?? 0)-\(viewModel.modelData?.data?.team2Score ?? 0)") .foregroundColor(.textColorGray) .font(.mulishBold(size: 20))
                        Text("Full Time") .foregroundColor(.appGreenColor) .font(.mulishRegular(size: 12)).padding(.top,2)
                        Text("\(viewModel.modelData?.data?.matchTime ?? 10)'") .foregroundColor(.appGreenColor) .font(.mulishRegular(size: 12)).padding(.top,1)
                    }.padding(.top,30)
                    Spacer()
                    VStack{
                        HStack{
                            
                        }.frame(width: 40,height: 40).background(Color.appGray).clipShape(.circle)
                        Text(viewModel.team2)
                            .foregroundColor(.textColorGray) .font(.mulishRegular(size: 15.0))
                    }.padding(.bottom,5).frame(width: 70,height: 30)
                }.padding(.horizontal,20)
                .frame(maxWidth: .infinity)
                .frame(height: 131)
                .background(Color.textFieldColor)
                .cornerRadius(15).padding(.horizontal).padding(.top)
                HStack{
                    Text("Summary:") .foregroundColor(.textColor) .font(.mulishBold(size: 20))
                    Spacer()
                }.padding(.horizontal).padding(.top)
                
                if !viewModel.goleLsit.isEmpty{
                ZStack{
                    VStack(spacing:0){
                        HStack{
                            Spacer()
                            Text(viewModel.team1) .foregroundColor(.white) .font(.mulishBold(size: 15))
                            Spacer()
                            Text(viewModel.team2) .foregroundColor(.white) .font(.mulishBold(size: 15)).padding(.leading,20).offset(x:30)
                            Spacer()
                        }.frame(height: 35).background(Color.appGreen).cornerRadius(10, corners: [.topLeft,.topRight]).padding(.horizontal).padding(.top)
                        HStack(spacing:0){
                            Color.textColorGray.frame(width: 0.5)
                            VStack(spacing:0){
                                ForEach(0..<viewModel.goleLsit.count, id: \.self){ index in
                                    let data = viewModel.goleLsit[index]
                                    VStack(spacing:0){
                                        HStack{
                                            
                                            HStack{
                                                Text("\(data.time?.extractMinutes() ?? "")'")
                                                    .foregroundColor(.textColorGray)
                                                    .font(.mulishMedium(size: 13))
                                                    .padding(.horizontal,5).frame(width: 35)
                                                Color.textColorGray.frame(width: 0.5)
                                            }.frame(width: 55)
                                            
                                            VStack(spacing:2){
                                                Text(data.teamName == viewModel.team1 ? data.teamName ?? "" : "") .foregroundColor(.textColorGray) .font(.mulishMedium(size: 13))
                                                
                                                //                                                Text(data.teamName == viewModel.team1 ? "" : "")
                                                //                                                    .foregroundColor(.textColorGray) .font(.mulishMedium(size: 10))
                                                
                                            }.frame(maxWidth: 50).padding(.horizontal,10)
                                            
                                            HStack{
                                                if data.teamName == viewModel.team1 {
                                                    if data.cardType != nil{
                                                        Image(systemName: data.cardType == "Red" ? "flag.fill" : "flag")
                                                            .foregroundColor(data.cardType == "Red" ? .red : .yellow)
                                                            .padding(.leading, 5)
                                                    }else{
                                                        VStack(alignment:.center){
                                                            if data.teamName == viewModel.team1 && data.goalType != "normal"{
                                                                Text("Pan")
                                                                    .foregroundColor(.textColorGray) .font(.mulishMedium(size: 10))
                                                            }
                                                            Image("fi_1165187")
                                                            
                                                        }
                                                    }
                                                }
                                            }.frame(width: 20)
                                            
                                            Color.textColorGray.frame(width: 0.5).padding(.leading,5)
                                            
                                            HStack{
                                                Text("10-20")
                                                    .foregroundColor(.textColorGray)
                                                    .font(.mulishMedium(size: 13))
                                                
                                                    .frame(width: 38)
                                                Color.textColorGray.frame(width: 0.5)
                                            }.frame(width: 55)
                                            
                                            Spacer()
                                            
                                            VStack(spacing:2){
                                                Text(data.teamName == viewModel.team2 ? data.teamName ?? "" : "") .foregroundColor(.textColorGray) .font(.mulishMedium(size: 13))
                                                //                                                Text(data.teamName == viewModel.team2 ? "" : "")
                                                //                                                    .foregroundColor(.textColorGray) .font(.mulishMedium(size: 10))
                                                
                                            }.offset(x:-10)
                                            
                                            
                                            HStack{
                                                if data.teamName == viewModel.team2 {
                                                    if data.cardType != nil{
                                                        Image(systemName: data.cardType == "Red" ? "flag.fill" : "flag")
                                                            .foregroundColor(data.cardType == "Red" ? .red : .yellow)
                                                            .padding(.horizontal,10).offset(x:-10)
                                                    }else{
                                                        VStack(alignment:.center){
                                                            if data.teamName == viewModel.team2 && data.goalType != "normal"{
                                                                Text("Pan")
                                                                    .foregroundColor(.textColorGray) .font(.mulishMedium(size: 10))
                                                            }
                                                            Image("fi_1165187")
                                                            
                                                        }.offset(x:-10)
                                                        
                                                    }
                                                }
                                            }.frame(width: 30)
                                        }
                                        if viewModel.goleLsit.count-1 != index{
                                            Color.textColorGray.frame(height: 0.5)
                                        }
                                        
                                    }.frame(height: 55)
                                }
                            }   .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.textColorGray, lineWidth: 0.5)).padding(.horizontal)
                        }
                    }
                    }
                }
            }
        }.onAppear{
           // viewModel.test()
          viewModel.footballScoreCardSummary()
        }
    }
}

#Preview {
    FootballScoreCardSummaryView(viewModel:  FootballScoreCardSummaryViewModel())
}
