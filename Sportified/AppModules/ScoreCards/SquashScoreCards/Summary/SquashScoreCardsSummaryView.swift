//
//  SquashScoreCardsSummaryView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 19/08/2024.
//

import SwiftUI

struct SquashScoreCardsSummaryView: View {
    @ObservedObject var viewModel: SquashScoreCardsSummaryViewModel
    var body: some View {
      
            VStack(spacing:0){
                
                HomeSecondaryAppBBar(title: "Squash Score Card", btnShareCallBack:  {
                    
                }).padding(.top,5)
                ScrollView(showsIndicators: false){
                HStack(spacing: 25) {
                    VStack{
                        HStack{
                            
                        }.frame(width: 40,height: 40).background(Color.appGray).clipShape(.circle)
                        Text(viewModel.team1) .foregroundColor(.textColorGray) .font(.mulishRegular(size: 15.0))
                    }.padding(.bottom,5).frame(width: 70,height: 30)
                    Spacer()
                    VStack{
                        Text("\(viewModel.modelData?.data?.team1Score ?? 0)-\(viewModel.modelData?.data?.team2Score ?? 0)") .foregroundColor(.textColorGray) .font(.mulishBold(size: 20))
//                        Text("Full Time") .foregroundColor(.appGreenColor) .font(.mulishRegular(size: 12)).padding(.top,2)
                        Text("01:30:25") .foregroundColor(.appGreenColor) .font(.mulishRegular(size: 12)).padding(.top,1)
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
               
                ///Game Details:
                HStack{
                    Text("Game Details:") .foregroundColor(.textColor) .font(.mulishBold(size: 20))
                    Spacer()
                }.padding(.horizontal).padding(.top)
               
                if !viewModel.goleLsit.isEmpty{
                    ZStack{
                        VStack(spacing:0){
                            HStack{
                                Spacer()
                                Text("Game") .foregroundColor(.white) .font(.mulishBold(size: 15))
                                Spacer()
                                Text("Player 1") .foregroundColor(.white) .font(.mulishBold(size: 15)).padding(.leading,20)
                                Spacer()
                                Text("Player 2") .foregroundColor(.white) .font(.mulishBold(size: 15)).padding(.leading,20)
                                Spacer()
                                Text("Winner") .foregroundColor(.white) .font(.mulishBold(size: 15)).padding(.leading,20)
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
                                                    Text("Game 1")
                                                        .foregroundColor(.textColorGray)
                                                        .font(.mulishMedium(size: 13))
                                                        .padding(.horizontal,5).frame(width: 75)
                                                    Color.textColorGray.frame(width: 0.5)
                                                }.frame(width: 75)
                                                
                                                VStack(spacing:2){
                                                    Text("21") .foregroundColor(.textColorGray) .font(.mulishMedium(size: 13))
                                                    
                                                    
                                                    
                                                }.frame(maxWidth: 60).padding(.horizontal,10)
                                                
                                                
                                                
                                                Color.textColorGray.frame(width: 0.5).padding(.leading,5)
                                                
                                                HStack{
                                                    Text("10-20")
                                                        .foregroundColor(.textColorGray)
                                                        .font(.mulishMedium(size: 13))
                                                    
                                                        .frame(width: 75)
                                                    Color.textColorGray.frame(width: 0.5)
                                                }.frame(maxWidth: 60).padding(.horizontal,10)
                                                
                                                Spacer()
                                                
                                                VStack(spacing:2){
                                                    Text("Player 1") .foregroundColor(.textColorGray) .font(.mulishMedium(size: 13))
                                                    
                                                    
                                                }.offset(x:-20)
                                                
                                                
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
                    
                //Player Performance:                
                HStack{
                    Text("Player Performance:") .foregroundColor(.textColor) .font(.mulishBold(size: 20))
                    Spacer()
                }.padding(.horizontal).padding(.top)
               
                if !viewModel.goleLsit.isEmpty{
                    ZStack{
                        VStack(spacing:0){
                            HStack{
                                Spacer()
                                Text("Statistics") .foregroundColor(.white) .font(.mulishBold(size: 15))
                                Spacer()
                                Text("Player 1") .foregroundColor(.white) .font(.mulishBold(size: 15)).padding(.leading,20).offset(x: -10)
                                Spacer()
                                Text("Player 2") .foregroundColor(.white) .font(.mulishBold(size: 15)).padding(.leading,20)
                              
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
                                                    Text("Game 1")
                                                        .foregroundColor(.textColorGray)
                                                        .font(.mulishMedium(size: 13))
                                                        .frame(width: 105)
                                                    // .frame(maxWidth: .infinity,alignment: .leading)
                                                    //  .padding(.horizontal,5).frame(width: 75)
                                                    Color.textColorGray.frame(width: 0.5)
                                                    
                                                }
                                                
                                                VStack(spacing:2){
                                                    Text("21") .foregroundColor(.textColorGray) .font(.mulishMedium(size: 13))
                                                        .padding(.horizontal,10)
                                                        .frame(width: 45)
                                                    
                                                    
                                                }.frame(width: 45)
                                                
                                                
                                                Spacer()
                                                
                                                Color.textColorGray.frame(width: 0.5).padding(.leading,5)
                                                
                                                HStack{
                                                    Text("10-20")
                                                        .foregroundColor(.textColorGray)
                                                        .font(.mulishMedium(size: 13))
                                                        .padding(.horizontal,10)
                                                }
                                                
                                                
                                                Spacer()
                                                
                                            }
                                            
                                            if viewModel.goleLsit.count-1 != index{
                                                Color.textColorGray.frame(height: 0.5)
                                            }
                                            
                                        }.frame(height: 55)
                                    }
                                }.overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.textColorGray, lineWidth: 0.5)).padding(.horizontal)
                            }
                        }
                    }
                }
            }
            
        }.onAppear{
            viewModel.test()
          viewModel.footballScoreCardSummary()
        }
    }
}

#Preview {
    SquashScoreCardsSummaryView(viewModel: SquashScoreCardsSummaryViewModel())
}


