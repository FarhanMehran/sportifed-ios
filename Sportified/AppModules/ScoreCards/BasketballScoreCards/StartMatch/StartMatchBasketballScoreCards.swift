//
//  StartMatchBasketballScoreCards.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 15/08/2024.
//

import SwiftUI

struct StartMatchBasketballScoreCards: View {
    @ObservedObject var viewModel: StartMatchBasketballScoreCardsViewModel
    var body: some View {
        
        ZStack{
            VStack{
                
                HomeSecondaryAppBBar(coordinator: viewModel.coordinator ,title: "Start a Match",showUndoButton: true, btnShareCallBack:  {
                    
                }).padding(.top,5)
                ScrollView{
                    HStack{
                        VStack{
                            HStack{
                                WebImageView(image: viewModel.nearbyMatchesitem?.teams?.first?.img ?? "Team A",placeholder: Image("Hard"))
                                    .frame(width: 100,height: 100)
                            }.frame(width: 100,height: 100).background(Color.appGray).clipShape(.circle)
                            
                            ListButton(title: viewModel.nearbyMatchesitem?.teams?.first?.name ?? "Team A", callBack: {}).padding(.horizontal)
                        }
                        Image.ic_vs.padding(.bottom,30)
                        VStack{
                            HStack{
                                WebImageView(image: viewModel.nearbyMatchesitem?.teams?.last?.img ?? "Team A",placeholder: Image("Hard"))
                                    .frame(width: 100,height: 100)
                            }.frame(width: 100,height: 100).background(Color.appGray).clipShape(.circle)
                            
                            ListButton(title: viewModel.nearbyMatchesitem?.teams?.last?.name ?? "Team b", callBack: {}).padding(.horizontal)
                        }
                        
                    }.padding(.top,30)
                    VStack(alignment: .leading){
                        HStack(spacing: 2){
                            Text("League Type").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        HStack{
                            ListButton2(title: "NBA (48 Minutes) ",
                                        bgColor: viewModel.matchTime == 0 ? .appGreenColor : .textFieldColor, foregroundColor: viewModel.matchTime == 0 ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.matchTime = 0
                            })
                            ListButton2(title: "FIBA (40 Minutes)",
                                        bgColor:viewModel.matchTime == 1 ? .appGreenColor : .textFieldColor,foregroundColor: viewModel.matchTime == 1 ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.matchTime = 1
                            })
                            ListButton2(title: "NCAA (40 Minutes)",
                                        bgColor:viewModel.matchTime == 2 ? .appGreenColor : .textFieldColor,foregroundColor: viewModel.matchTime == 2 ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.matchTime = 2
                                
                            })
                            
                        }
                        HStack{
                            
                            ListButton2(title: "Add Custom Duration",
                                        bgColor:viewModel.matchTime == 3 ? .appGreenColor : .textFieldColor,foregroundColor:viewModel.matchTime == 3 ? .white : .textColor,cornerRadius: 20 ,callBack: {
                                viewModel.matchTime = 3
                                viewModel.showCustomTimePopUp.toggle()
                            })
                           
                            
                            
                        }.padding(.top,5)
                        
                        HStack(spacing: 2){
                            Text("Additional Options").font(Font.mulishMedium(size: 18)).foregroundColor(Color.textColor)
                            Text("*").font(Font.mulishMedium(size: 18)).foregroundColor(Color.red)
                        }.padding(.top,25)
                        HStack {
                            Text("Extra Time").foregroundColor(Color.textColor).font(Font.mulishMedium(size: 16))
                            Spacer()
                            
                            Image(viewModel.btnExtraTime ? "ons" : "offs").onTapGesture {
                                viewModel.btnExtraTime.toggle()
                            }
                            
                        }.padding().frame(height: 65).background(Color.textFieldColor).cornerRadius(10)
                
                    }
                    
                }.padding(.horizontal)
                Spacer()
                AppButton(title: "Next", callBack: {
                   viewModel.btnClickLeague()
                }).padding(.top,50).padding(.horizontal)
            }
            if viewModel.showCustomTimePopUp{
                CustomTimePOPUP(text: $viewModel.txtcustomTime, showCustomTimePopUp: $viewModel.showCustomTimePopUp) {
                    viewModel.selectTime = viewModel.txtcustomTime
                    viewModel.txtcustomTime = ""
                    
                }
            }
        }.onAppear{
           viewModel.test()
        }.showToast(toastText: viewModel.validationText, isShowing: $viewModel.validationAlert)
    }
}


#Preview {
    StartMatchBasketballScoreCards(viewModel: StartMatchBasketballScoreCardsViewModel())
}
